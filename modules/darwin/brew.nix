{inputs, config, pkgs, ...}: {
  
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "uninstall";
    };
    global = {
      brewfile = true;
      };
    masApps = {
      Keynote = 409183694; # added to force updates
      iMovie = 408981434; # added to force updates
      Pages = 409201541; # added to force updates
      GarageBand = 682658836; # added to force updates
      Numbers = 409203825; # added to force updates
      WindowsApp = 1295203466 # moving win app to mas to supress updates
    }; # Mac Store apps via Brew MAS - https://mynixos.com/nix-darwin/option/homebrew.masApps
    taps = [
        "fujiapple852/trippy"
        {
          name = "konradsz/igrep";
          clone_target = "https://github.com/konradsz/igrep.git";
          force_auto_update = true;
        }
        ];
    casks = [ 
      {
        name = "1password"; # Password manager
        greedy = true;
      }
      {
        name = "1password-cli"; # CLI for 1password
        greedy = true;
      }
      {
        name = "alacritty"; # Terminal
        greedy = true;
      }
      {
        name = "alcove"; # Notchy goodness
        greedy = true;
      }
      {
        name = "alt-tab"; # Enhanced Cmd + Tab behavior akin to Windows
        greedy = true;
      }  
      {
        name = "bartender"; # Cleanup the sys tray
        greedy = true;
      }
      {
        name = "brave-browser"; # Brave browser
        greedy = true;
      }
      {
        name = "docker-desktop"; # Docker Daemon - Need to decide between this and Podman
        greedy = true;
      }
      {
        name = "disk-inventory-x"; # Disk usage analysis
        greedy = true;
      }
      {
        name = "claude-code"; # Anthropic Claude AI client
        greedy = true; 
      }
      {
        name = "geany"; # notepad++ replacement
        greedy = true;
      }
      {
        name = "ghostty"; # Terminal
        greedy = true;
      }
      {
        name = "keyclu"; # Keyboard shortcut hints
        greedy = true;
      }
      {
        name = "lulu"; #  Firewall 
        greedy = true;
      }
      {
        name = "microsoft-edge"; # Edge for use with M365 items 
        greedy = true;
      }
      {
        name = "Netiquette"; # Objective-see socket monitor
        greedy = true;
      }
      {
        name = "notunes"; # Disable iTunes
        greedy = true;
      }
      {
        name = "obsidian"; # 2nd Brain
        greedy = true;
      }
      {
        name = "postman"; # API testing
        greedy = true;
      }
      {
        name = "powershell"; # Powershell
        greedy = true;
      }
      {
        name = "raycast" ; # Spotlight replacement
        greedy = true;
      }
      {
        name = "signal"; #Desktop client for Signal
        greedy = true;
      }
      {
        name = "spotify"; #Muzak
        greedy = true;
      }
      {
        name = "synology-drive"; #cloud drive
        greedy = true;
      }
      {
        name = "tailscale-app"; #  Tailscale VPN GUI
        greedy = true;
      }
      {
        name = "TaskExplorer"; #Objective-See process explorer
        greedy = true;
      }
      {
        name = "vcam"; # Virtual Camera
        greedy = true;
      }
      {
        name = "visual-studio-code"; # Make code pretty
        greedy = true;
      }
      {
        name = "wavebox"; # Webapp container
        greedy = true;
      }
      {
        name = "whisky"; # MacOS implementation of Wine Bottles for running windows apps
        greedy = true;
      }
      {
        name = "wifiman"; # Ubiquiti wifi tool and VPN client
        greedy = true;
      }
      {
        name = "wireshark-app"; # Network packat analysis
        greedy = true;
      }
    ];
    brews = [ 
      "awscli" # Breaks when done nix native
      "curl" # the magical curl command
      "fzf" # Nix native is behind
      "igrep" # grep replacements
      "lazydocker" # Docker TUI
      "lazygit" # Git TUI
      "mas" # Mac app store
      "node" # NodeJS
      "oh-my-posh" # Shell prompt theme engine
      "p0f" # Passive OS Fingerprinting
      "sherlock" 
      "squiid" # TUI RPN Calculator
      "tailscale" # VPN
      "trippy" # Move to Nix native ?
      "uv" # Python package management
      "zellij" # Moved from nix to brew - 082025 (nix is behind)
      "zoxide" # Nix native is behind
      ]; 
  };
}
