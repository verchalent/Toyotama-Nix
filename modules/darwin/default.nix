{ pkgs, ... }: {
  # Setting Reference https://nix-darwin.github.io/nix-darwin/manual/index.html
  users.users.justin.home = "/Users/justin";
  imports = [./brew.nix];
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [ bash zsh ];
    systemPackages = [ pkgs.coreutils];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  fonts.packages = [ 
  # For package names look at cask https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.meslo-lg
    ];

  system = {
    primaryUser = "justin"; # Set the primary user for the system
    stateVersion = 6; # Moving to latest

    defaults = {
      ActivityMonitor = {
        ShowCategory = 101; # Show All Processes, Hierarchally as default
      };
     
      dock = {
        autohide = true; # Autohide Dock  
        launchanim = false; # Turn off Animate opening applications from the Dock
        mouse-over-hilite-stack = true; # Enable highlight hover effect 
        mru-spaces = false; # Prevent automatic rearanging of spaces
        orientation = "left"; # Set Position of the dock on screen
        persistent-apps = [
          {
            app = "/Applications/Alacritty.app";
          }
          {
            app = "/System/Applications/System Settings.app";
          }
          {
            app = "/System/Applications/Utilities/Activity Monitor.app";
          }
        ];
        show-recents = false; # Turn off recents in Dock
        tilesize = 48; # Size of the icons in the dock.
      };
    
      finder = {
        _FXShowPosixPathInTitle = true; # Show the full POSIX filepath in the window title
        _FXSortFoldersFirst = true; # Sort folders first in Finder
        AppleShowAllExtensions = true; # Show all file extensions in Finder.
        FXEnableExtensionChangeWarning = false; # Disable the warning when changing file extensions
        FXPreferredViewStyle = "Nlsv"; # Change the default finder view. “icnv” = Icon view, “Nlsv” = List view, “clmv” = Column View, “Flwv” = Gallery View The default is icnv.
        FXRemoveOldTrashItems = true; # Remove old trash items after 30 days
        NewWindowTarget = "Home"; # Set the default new window target to home directory
        QuitMenuItem = true; # Enable the Quit menu item in Finder
        ShowExternalHardDrivesOnDesktop = true; # Show external hard drives on the desktop
        ShowHardDrivesOnDesktop = false; # Don't show internal hard drives on the desktop
        ShowMountedServersOnDesktop = true; # Show mounted servers on the desktop
        ShowPathbar = true; # Show the path bar at the bottom of Finder windows
        ShowRemovableMediaOnDesktop = true; # Show removable media on the desktop
        ShowStatusBar = true; # Show status bar at bottom of finder windows with item/disk space stats.
      };

      LaunchServices.LSQuarantine = false; # Disable quarantine for all applications
      
      NSGlobalDomain = {
        AppleShowAllExtensions = true; # Show all file extensions
        InitialKeyRepeat = 14; # speed up key repeat behavior
        KeyRepeat = 1;
        "com.apple.sound.beep.feedback" = 0; # Disable system beep feedback
        "com.apple.sound.beep.volume" = 0.000; # Mute alert volume
        "com.apple.swipescrolldirection" = false; # Disable Natural Scrolling direction
        "com.apple.mouse.tapBehavior" = 1; # Enable tap to click
        NSDocumentSaveNewDocumentsToCloud = false; # Save new documents to local disk
      };

      spaces = {
        spans-displays = false; # Disable spanning displays
      };

      trackpad = {
        Clicking = true; # Enable tapping the trackpad to click
        TrackpadThreeFingerDrag = false; # Enable/disable three-finger drag. Default is false.
      };
      
      menuExtraClock.Show24Hour = true; # Set Clock to 24 Hour Mode
      loginwindow.GuestEnabled = false; # Disable guest account

      WindowManager ={
        EnableStandardClickToShowDesktop = false; # Enable standard click to show desktop
        StageManagerHideWidgets = true; # Hide widgets in stage manager
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = false; # Remap Caps Lock to Escape - Disabled
    #  swapLeftCtrlAndFn = true; # Swap left Control and Function keys - 06.26.25 - removed as this maps all keyboards. Need to ensure it only applies to laptop
      
    };
  };
  
  networking = {
    applicationFirewall = {
      enable = true;
      enableStealthMode = true;
    };
  };
}
