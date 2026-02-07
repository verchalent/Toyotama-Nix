{ ... }: {
  system.defaults.CustomUserPreferences."com.raycast.macos" = {
    # Window behavior
    raycastPreferredWindowMode = "compact";
    raycastShouldFollowSystemAppearance = true;

    # Global hotkey (Cmd+Space)
    raycastGlobalHotkey = "Command-49";

    # AI directories Raycast is allowed to access
    "raycastAI_allowedDirectories" = [
      "/Applications"
      "/Users/justin"
    ];

    # Folder permissions
    "permissions.folders.read:/Users/justin/Desktop" = true;
    "permissions.folders.read:/Users/justin/Documents" = true;
    "permissions.folders.read:/Users/justin/Downloads" = true;
    "permissions.folders.read:cloudStorage" = true;
    "permissions.folders.read:removableVolumes" = true;

    # Misc
    useHyperKeyIcon = false;
    NSNavPanelExpandedSizeForOpenMode = "{800, 448}";
  };
}
