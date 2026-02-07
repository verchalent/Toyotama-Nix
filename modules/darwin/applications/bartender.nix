{ config, ... }: {
  system.defaults.CustomUserPreferences."com.surteesstudios.Bartender" = {
    # Profile settings — which menu bar items to show/hide
    ProfileSettings = {
      activeProfile = {
        Show = [
          "com.surteesstudios.Bartender-statusItem"
          "com.apple.controlcenter-Battery"
          "com.apple.controlcenter-WiFi"
        ];
        Hide = [
          "com.objective-see.lulu.app-Item-0"
          "com.lwouis.alt-tab-macos-Item-0"
          "com.bookry.wavebox-Item-0"
          "com.1password.1password-Item-0"
          "com.microsoft.rdc.macos-Item-0"
          "com.electron.ollama-Item-0"
          "special.AllOtherItems"
          "com.apple.Spotlight-Item-0"
          "com.raycast.macos-raycastIcon"
        ];
        AlwaysHide = [];
        name = "Profile";
        iconIsTemplate = true;
        isSpecial = true;
        leaveAlwaysHiddenItems = false;
        description = "";
      };
    };

    # Behavior
    HideItemsWhenShowingOthers = false;
    MouseExitDelay = "0.4";

    # Updates — disabled (managed by brew)
    SUAutomaticallyUpdate = false;
    SUEnableAutomaticChecks = false;
  };

  # Inject license key from sops secret at activation time
  # This keeps the license out of the Nix store
  system.activationScripts.postActivation.text = ''
    if [ -f "${config.sops.secrets.bartender_license.path}" ]; then
      defaults write com.surteesstudios.Bartender license5 "$(cat "${config.sops.secrets.bartender_license.path}")"
    fi
  '';
}
