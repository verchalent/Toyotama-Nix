{ ... }: {
  imports = [
    ./dotfiles.nix
    ./git.nix
    ./packages.nix
    ./programs.nix
    ./tmux.nix
    ./zsh.nix
    ./nu.nix
  ];

  home.stateVersion = "25.11";

  home.sessionVariables = {
    PAGER = "less";
    CLICOLOR = 1;
    EDITOR = "nvim";
  };
}
