{ pkgs, ... }: {
  home.packages = with pkgs; [
    age
  #  curl - moved to homebrew due to errors with curl-impersonate
    fd
    helix
    less
    lsd
    neofetch
    neovim
    python3
    procs
    ripgrep
    tealdeer
    zsh-powerlevel10k
  ];
}
