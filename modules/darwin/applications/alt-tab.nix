{ ... }: {
  system.defaults.CustomUserPreferences."com.lwouis.alt-tab-macos" = {
    # Appearance
    appearanceStyle = 0;

    # Hotkey — Cmd as the hold shortcut
    holdShortcut = "\\U2318";

    # Update policy (2 = check but don't auto-install)
    updatePolicy = 2;
    SUAutomaticallyUpdate = true;
    SUEnableAutomaticChecks = true;

    # Disable MS AppCenter telemetry
    MSAppCenterNetworkRequestsAllowed = false;
  };
}
