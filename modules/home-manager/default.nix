{ ... }: {
  imports = [
    ./dotfiles.nix
    ./git.nix
    ./packages.nix
    ./programs.nix
    ./tmux.nix
    ./zsh.nix
  # ./nu.nix # Broken 02-02-26
  ];

  home.stateVersion = "25.11";

  home.sessionVariables = {
    PAGER = "less";
    CLICOLOR = 1;
    EDITOR = "nvim";
  };
}
