# Toyotama-Nix

Continually evolving declarative macOS environment managed via Nix Flakes.

"It worked yesterday" is expected; this repo tracks my daily driver machine and is opinionated. Fork/adapt at your own risk.

## Goals / Philosophy

- Rebuild any new Apple Silicon mac quickly (MacBook / mini) with manual post steps.
- Keep userland (shells, editors, dotfiles) and system state (defaults, fonts, casks, MAS apps) in version control.
- Prefer Nix-native packages; fall back to Homebrew where Nix is behind or a GUI app/cask is simpler.
- Stay on unstable channels intentionally to test newer tooling; accept occasional breaks.
- Make updates painless via a single `nixup` alias / script.

## Stack Overview

Component | Purpose
--------- | -------
`flake.nix` | Entry point defining inputs (nixpkgs-unstable, nix-darwin, home-manager) and the `darwinConfiguration`.
`modules/darwin` | System-level configuration: macOS defaults, fonts, firewall, shell enablement, Homebrew integration.
`modules/darwin/brew.nix` | Curated list of brews, casks, MAS apps, and taps (where Nix lacks parity or GUI needed).
`modules/home-manager` | Per-user environment: shells (zsh, Nushell), tmux, git, dotfile symlinks, packages & session vars.
`modules/home-manager/scripts/nixup.sh` | Helper invoked by alias to update flake inputs and rebuild system.
`modules/home-manager/dotfiles/*` | Editor / terminal / prompt / misc config files symlinked into `$HOME`.

## Notable Features

- macOS defaults: Dock, Finder, key repeat, trackpad, login window, Activity Monitor, clock, Spaces, etc.
- Homebrew managed with auto upgrade + cleanup; MAS app IDs pinned for forced update tracking.
- Security: Application firewall enabled with stealth mode; quarantine disabled (trade‑off; adjust to taste).
- Shell ergonomics: zsh with autosuggestions, syntax highlighting, powerlevel10k, case‑insensitive completion, fzf, zoxide, atuin.
- Alternate shells: Nushell (config via dotfile), PowerShell (profile + module manifests), plus tmux with mouse enhancements.
- Editor/tooling: Neovim + Helix + Geany theme, bat (Dracula), fd/rg/lsd replacements, procs, direnv+nix-direnv, tealdeer.
- Fonts: JetBrains Mono & Meslo Nerd Fonts for rich glyph/prompt support.
- Aliases: `nixswitch`, `nixup`, `nixclean`, plus replacements (`cat`->`bat`, `ls`->`lsd`, `cd`->`z`, `vi`->`hx`).
- Local LLM tooling via `ollama` cask (experimentation).

## Rationale: Brew vs Nix

The goal is to have everything in Nix, but some packages intentionally remain on Homebrew due to

- Faster upstream (e.g. `fzf`, `zoxide`, `zellij` at the moment of pinning).
- GUI / cask only distribution (most apps in `casks`).
- Temporary workarounds where Nix derivations lag or introduce friction (e.g. `awscli`).



## Files & Directories (Quick Map)

```text
Toyotama-Nix/
├── flake.nix                     # Flake inputs + darwinConfiguration definition
├── flake.lock                    # Pinned versions of all inputs
├── modules/
│   ├── darwin/                   # System (nix-darwin) layer
│   │   ├── default.nix           # macOS defaults, fonts, firewall, shells
│   │   ├── brew.nix              # Homebrew (brews, casks, MAS, taps)
│   │   └── appPrefs.nix          # (WIP) app-specific preference domains
│   └── home-manager/             # User (home-manager) layer
│       ├── default.nix           # Aggregates per-feature modules & packages
│       ├── zsh.nix               # zsh config, plugins, aliases
│       ├── tmux.nix              # tmux settings & plugins
│       ├── nu.nix                # Nushell enable + config
│       ├── git.nix               # git author + signing + defaults
│       ├── scripts/
│       │   └── nixup.sh          # Update flake inputs + rebuild (used by alias)
│       └── dotfiles/             # Symlink sources into $HOME
│           ├── alacritty.toml
│           ├── helix.toml
│           ├── nvim.rc
│           ├── nvim-plugins.lua
│           ├── zellij.kdl
│           ├── p10k.zsh
│           ├── inputrc
│           ├── direnvrc
│           ├── geany.conf / retro.conf
│           ├── ohmyposh-nu.json
│           └── (other editor / shell assets)
└── LICENSE
```

## Install & Bootstrap

This assumes cloning into `~/src/`.

1) Open a new Terminal
2) Install Nix ``sh <(curl -L https://nixos.org/nix/install)``
3) Install Brew ``/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"``
4) Close the Terminal app and open a new terminal
5) Install git with Brew ``brew install git`` (you may need to source brew)
6) Clone this repo to src (or modify below accordingly)
7) Install the flake ``nix  --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake ~/src/Toyotama-Nix``

After the final step macOS defaults, brew packages, fonts, and user environment should converge. Log out/in or restart affected apps (Dock, Finder) if some settings lag.

## Daily Usage

- Update everything: `nixup` (alias → runs `nix flake update` + `darwin-rebuild switch`).
- Rebuild without updating inputs: `nixswitch`.
- Garbage collect old store paths: `nixclean`.

If a rebuild fails, inspect recent flake input changes (`git diff flake.lock`), revert or pin as needed.

## Customizing / Forking

1. Fork the repo.
2. Search/replace username paths and hostname.
3. Remove or change GPG/SSH signing key inside `git.nix`.
4. Trim casks & brews to what you actually use.
5. Adjust macOS defaults (see comments in `modules/darwin/default.nix`).

Re-run `nixswitch` after each change to validate.

## Future / TODO

- Merge with other system repos into a single multi-system/multi-arch config
- Move more GUI app preference domains into `appPrefs.nix` once stabilized.
- Reassess which brews can return to pure Nix as packages catch up.
- Add automated flake update CI (with build test) before local adoption.
- Explore secrets management integration (1Password CLI already present for SSH signing).

## License

MIT (see `LICENSE`). Use, adapt, no warranty.
