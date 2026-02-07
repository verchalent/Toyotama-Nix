{ ... }: {
  system.defaults = {
    LaunchServices.LSQuarantine = false; # Disable quarantine for all applications

    loginwindow = {
      DisableConsoleAccess = true; # Disables the ability for a user to access the console by typing ">console" for a username at the login window.
      GuestEnabled = false; # Disable guest account
      SHOWFULLNAME = false;
    };
  };

  networking = {
    applicationFirewall = {
      enable = true;
      enableStealthMode = true;
    };
  };
}
