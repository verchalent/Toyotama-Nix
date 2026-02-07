# PRD: Toyotama-Nix Configuration Streamlining

## Current State

Toyotama-Nix is a nix-darwin + home-manager flake for an Apple Silicon Mac (user `justin`, host `toyotama`). It currently manages macOS system defaults, Homebrew packages, shell environments (zsh, nushell, pwsh), terminal configs, and dotfiles.

**Pain points:**
- `modules/darwin/default.nix` is a monolithic 122-line file mixing system defaults, fonts, firewall, and login settings
- `modules/home-manager/default.nix` is a catch-all aggregator that also inlines package lists and misc config
- sops-nix is wired into `flake.nix` but only has test/placeholder secrets — no real consumption anywhere
- App preferences (Raycast, Bartender, Alt-Tab, etc.) are not managed declaratively — only raw `defaults read` dumps exist in `temp/`
- `nix-darwin` and `sops-nix` flake inputs are pinned to Dec 2024; nixpkgs/home-manager to Feb 2025
- Nushell module is noted as broken (02-02-26)
- The deleted `appPrefs.nix` and empty `modules/darwin/applications/` directory represent an unfinished refactor

---

## Goals

### 1. Finish Implementing Secrets Management (sops-nix)

**Architecture:** 1Password is the primary secrets store. The actual SSH keys, API tokens, and app license keys live in 1Password. sops-nix's role is to encrypt the *credentials needed to access 1Password* (e.g., the SSH key used for 1Password CLI/agent authentication). This adds a layer of encryption at rest — the SSH key is currently unencrypted on disk, and while it's useless without the user unlocking 1Password, sops provides defense-in-depth.

**Current state:** `.sops.yaml` and `secrets/secrets.yaml` exist with test data. `sops-nix` is imported in `flake.nix` but no module actually references `sops.secrets.*`. The 1Password SSH key (`1pass_sshpub` in secrets.yaml) is a placeholder — the actual private key used for 1Password access sits unencrypted on disk.

**Target state:**
- Encrypt the 1Password access SSH key (private key) via sops so it's not plaintext on disk
- Wire the decrypted key path into the modules that need it (git SSH signing, 1Password agent, etc.)
- Ensure the sops-decrypted key is available at the right time (before 1Password agent starts)
- Framework should support adding more 1Password access credentials over time (e.g., service account tokens, CLI auth tokens)
- Clean up placeholder secrets (`hello`, `example_key`, etc.) from `secrets.yaml`
- Document the AGE key setup/recovery process and the sops-1Password trust chain in README

**Trust chain:** AGE key (unlocks sops) -> SSH key (authenticates to 1Password) -> 1Password (stores all real secrets)

**Decisions needed:**
- [ ] Per-module secret declarations vs. centralized `secrets.nix`
- [ ] Where the decrypted SSH key should be placed and what permissions it needs
- [ ] Whether the 1Password agent config needs updating to point at the sops-managed key path

### 2. Reduce File Complexity / Increase Readability

**Current state:** Two large files (`darwin/default.nix`, `home-manager/default.nix`) do too much.

**Target decomposition:**

```
modules/
├── darwin/
│   ├── default.nix            # imports only, system.stateVersion
│   ├── brew.nix               # (already separated — keep as-is)
│   ├── system-defaults.nix    # Dock, Finder, NSGlobalDomain, keyboard, trackpad
│   ├── security.nix           # Firewall, stealth mode, quarantine, login window
│   ├── fonts.nix              # Font package declarations
│   └── applications/
│       ├── default.nix        # imports app-specific files
│       ├── raycast.nix        # com.raycast.macos defaults
│       ├── bartender.nix      # com.surteesstudios.Bartender defaults
│       └── alt-tab.nix        # com.lwouis.alt-tab-macos defaults
├── home-manager/
│   ├── default.nix            # imports only, home.stateVersion, user basics
│   ├── packages.nix           # home.packages list (extracted from default.nix)
│   ├── git.nix                # (already separated — keep as-is)
│   ├── zsh.nix                # (already separated — keep as-is)
│   ├── tmux.nix               # (already separated — keep as-is)
│   ├── nu.nix                 # (fix or remove if still broken)
│   ├── dotfiles/              # (keep as-is)
│   ├── pwsh/                  # (keep as-is)
│   ├── scripts/               # (keep as-is)
│   └── wallpaper/             # (keep as-is)
└── secrets.nix                # sops.secrets declarations (or inline per-module)
```

**Principle:** Each file does one thing. `default.nix` files become import-only aggregators.

### 3. Ensure Everything Is Up to Date

**Actions:**
- Run `nix flake update` to bump all inputs (nixpkgs, home-manager, nix-darwin, sops-nix)
- Audit `brew.nix` for stale/unused casks and brews
- Fix or remove the broken `nu.nix` nushell module
- Verify `home.stateVersion` and `system.stateVersion` match current channel
- Check for any deprecated nix-darwin or home-manager options in use

### 4. App Settings Management Framework

**Problem:** Apps like Raycast, Bartender, and Alt-Tab have extensive preferences only configurable through `defaults write`. These settings are lost on reinstall or new machine setup.

**Proposed framework:**

#### a) Defaults Capture Script (`scripts/capture-defaults.sh`)

```bash
#!/usr/bin/env bash
# Usage: capture-defaults.sh <bundle-id> [output-file]
# Captures `defaults read` output and converts to nix-compatible format
#
# Steps:
# 1. defaults read <bundle-id> > raw dump
# 2. Parse plist key-value pairs
# 3. Output a .nix file skeleton with system.defaults.CustomUserPreferences.<bundle-id>
```

This script should:
- Accept a macOS bundle ID (e.g., `com.raycast.macos`)
- Run `defaults read` and capture the output
- Convert plist types to Nix types (strings, ints, bools, arrays, dicts)
- Generate a `.nix` file template under `modules/darwin/applications/`
- Flag keys that look like secrets/tokens for sops integration

#### b) Per-App Nix Modules

Each app gets a file in `modules/darwin/applications/<app>.nix` using `system.defaults.CustomUserPreferences`:

```nix
{ config, lib, ... }:
{
  system.defaults.CustomUserPreferences."com.raycast.macos" = {
    raycastPreferredWindowMode = "compact";
    raycastShouldFollowSystemAppearance = true;
    raycastGlobalHotkey = "Command-49";
    # ...
  };
}
```

#### c) Secrets Integration for App Keys

Keys/tokens found in app defaults should be:
1. Extracted from the defaults dump
2. Added to `secrets/secrets.yaml` (encrypted with sops)
3. Referenced in the app module via `sops.secrets.<name>.path` or a script that writes them post-activation

**Note:** `system.defaults.CustomUserPreferences` writes at system activation time, but sops secrets are files. For keys that apps read from defaults (not files), we may need an activation script:

```nix
system.activationScripts.postActivation.text = ''
  defaults write com.raycast.macos licenseKey "$(cat ${config.sops.secrets.raycast_license.path})"
'';
```

#### d) Apps to Target (Priority Order)

| App | Bundle ID | Complexity | Has Secrets? |
|-----|-----------|-----------|--------------|
| Raycast | com.raycast.macos | Medium (temp/raycast_defaults exists) | Possible (AI keys, extensions) |
| Bartender | com.surteesstudios.Bartender | Medium (temp/bartender_defaults exists) | Possible (license) |
| Alt-Tab | com.lwouis.alt-tab-macos | Low (temp/alttab_defaults exists) | No |
| 1Password | com.1password.1password | Low (mostly managed by app) | N/A (manages its own) |

---

## Implementation Phases

### Phase 0: Best-Practice Audit & Cleanup
- Review all existing modules against nix-darwin and home-manager best practices
- Ensure `flake.nix` follows current flake conventions (clean inputs, minimal outputs logic, config pushed to modules)
- Replace any anti-patterns: hardcoded paths, inline `let` blocks that should be options, raw strings where structured attrs exist
- Use `lib` utilities where appropriate (e.g., `mkIf`, `mkEnableOption`, `mkMerge`) instead of ad-hoc conditionals
- Ensure consistent formatting and naming conventions across all files
- Remove dead code, stale comments, and leftover WIP artifacts (e.g., the deleted `appPrefs.nix`)
- Validate that all module function signatures are consistent (`{ config, lib, pkgs, ... }:`)
- This phase sets the baseline — every subsequent phase should maintain these standards

### Phase 1: Structural Refactor
- Split `darwin/default.nix` into `system-defaults.nix`, `security.nix`, `fonts.nix`
- Extract `home-manager/default.nix` package list into `packages.nix`
- Make both `default.nix` files import-only
- Verify build still succeeds after each split

### Phase 2: Update Dependencies
- `nix flake update`
- Check if nushell upstream fix has landed; if so, re-enable `nu.nix` and test
- Rebuild and test

### Phase 3: Secrets Management
- Encrypt the 1Password access SSH private key with sops (the primary use case)
- Wire the sops-decrypted key path into git SSH signing and 1Password agent config
- Ensure decryption happens early enough (before 1Password agent / SSH agent starts)
- Remove placeholder test secrets (`hello`, `example_key`, etc.) from `secrets.yaml`
- Document the full trust chain (AGE -> sops -> SSH key -> 1Password -> real secrets) in README
- Framework should allow adding more 1Password access credentials over time
- For app secrets that live in 1Password but need injecting into macOS defaults, evaluate approach:
  - Option A: `defaults write` in activation script reading from 1Password CLI
  - Option B: launchd agent post-login that pulls from 1Password and writes defaults
  - Decision deferred to implementation

### Phase 4: App Preferences Framework
- Build `capture-defaults.sh` script to dump and convert app prefs to Nix
- Convert existing temp dumps (Raycast, Bartender, Alt-Tab) to **curated** nix modules — important settings only, not full dumps
- Wire any discovered secrets/license keys through sops
- Test full rebuild with app defaults applied

---

## Resolved Questions

1. **Secrets architecture:** 1Password is the real secrets store. sops encrypts the *access credentials to 1Password* (SSH key) for defense-in-depth. The SSH key is currently unencrypted on disk — functional but not ideal since it's the gateway to everything in 1Password.
2. **Nushell:** Keep it. It was disabled due to an upstream Nix bug, not abandoned. Re-enable and test once the upstream fix lands (may already be fixed).
3. **App defaults scope:** Curated important settings only — maintainable and intentional over noisy full dumps.
4. **Secrets in defaults injection:** Open to suggestions — will prototype during Phase 3 and pick the cleanest working approach.
5. **Homebrew casks:** All 38 are actively used. No audit needed.
