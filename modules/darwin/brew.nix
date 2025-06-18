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
        name = "adobe-creative-cloud"; # Adobe CC
        greedy = true;
      }
      {
        name = "alacritty"; # Terminal
        greedy = true;
      }
      {
        name = "alacritty"; # Terminal
        greedy = true;
      }  
      {
        name = "alt-tab"; # Enhanced Cmd + Tab behavior akin to Windows
        greedy = true;
      }  
      {
        name = "amazon-workspaces"; # Client for AWS DAAS
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
        name = "claude"; # Claude AI assistant
        greedy = true;
      }
      {
        name = "docker"; # Docker Desktop
        greedy = true;
      }
      {
        name = "disk-inventory-x"; # Disk usage analysis
        greedy = true;
      }
      {
        name = "firefox"; # web browsing goodness
        greedy = true;
      }
      {
        name = "geany"; # notepad++ replacement
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
        name = "notunes"; # Disable iTunes
        greedy = true;
      }
      {
        name = "obsidian"; # 2nd Brain
        greedy = true;
      }
      {
        name = "ollama"; # Local LLMs
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
        name = "windows-app"; # RDP+ client
        greedy = true;
      }
      {
        name = "wireshark"; # Network packat analysis
        greedy = true;
      }
      {
        name = "zen-browser"; # Browser for testing
        greedy = true;
      }
    ];
    brews = [ 
      "awscli" # Breaks when done nix native
      "fzf" # Nix native is behind
      "igrep" # grep replacements
      "lazydocker" # Docker TUI
      "node" # NodeJS
      "trippy" # Move to Nix native ?
      "uv" # Python package management
      "zoxide" # Nix native is behind
      ]; 
  };
}
