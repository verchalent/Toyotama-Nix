{ pkgs, ... }: {
  # Setting Reference https://nix-darwin.github.io/nix-darwin/manual/index.html
  imports = [
    ./brew.nix
    ./fonts.nix
    ./security.nix
    ./system-defaults.nix
    ./applications
  ];

  users.users.justin = {
    home = "/Users/justin";
    uid = 501; # Set UID for justin to 501 - added to fix error 12.04.25
  };

  programs.zsh.enable = true;

  environment = {
    shells = with pkgs; [ bash zsh ];
    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system = {
    primaryUser = "justin"; # Set the primary user for the system
    stateVersion = 6; # Moving to latest
  };
}
