{ pkgs, ... }: {
  imports = [
    ./zsh.nix
    ./tmux.nix
    ./nu.nix
    ];
  home.stateVersion = "24.11";
  # specify my home-manager configs
  home.packages = with pkgs; [
    curl
    fd
    helix
    less
    lsd
    mpv
    neofetch
    neovim
    podman
    python3
    procs
    ripgrep
    tealdeer
    vimPlugins.tmux-nvim
    zellij
    zsh-powerlevel10k
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
  
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    };

  programs.bat = {
    enable = true;
    config.theme = "Dracula";
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = { #Nix was smashing git config. Added 03.25
    enable = true;
    userName = "PestyLint";
    userEmail = "me@example.com";
    includes = [
      { path = "~/.gitconfig.local"; }
    ];
  };

  programs.pay-respects = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Symlinks for files not managed natively by nix
  home.file.".config/alacritty/alacritty.toml".source=./dotfiles/alacritty.toml;
  home.file.".config/nvim/init.vim".source = ./dotfiles/nvim.rc;
  home.file.".config/nvim/init.lua".source=./dotfiles/nvim-plugins.lua;
  home.file.".config/powershell/Microsoft.PowerShell_profile.ps1".source=./pwsh/Microsoft.PowerShell_profile.ps1;
  home.file.".config/powershell/modules_aws.txt".source=./pwsh/modules_aws.txt;
  home.file.".config/powershell/modules.txt".source=./pwsh/modules.txt;
  home.file.".config/zellij/config.kdl".source=./dotfiles/zellij.kdl;
  home.file.".inputrc".source = ./dotfiles/inputrc;
  home.file.".p10k.zsh".source = ./dotfiles/p10k.zsh;
  home.file.".config/direnv/direnvrc".source = ./dotfiles/direnvrc;
  home.file.".config/geany/colorschemes/retro.config".source = ./dotfiles/retro.conf;
  home.file.".config/geany/geany.conf".source = ./dotfiles/geany.conf;
  home.file.".config/helix/config.toml".source = ./dotfiles/helix.toml;
  home.file.".config/nushell/config.nu".source = ./dotfiles/config.nu;
  home.file.".config/ohmyposh/ohmyposh-nu.json".source = ./dotfiles/ohmyposh-nu.json;
}