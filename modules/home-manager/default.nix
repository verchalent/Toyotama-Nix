{ pkgs, ... }: {
  imports = [
    ./zsh.nix
    ./tmux.nix
  #  ./nu.nix. #Broken 02-02-26
    ./git.nix
    ];
  home.stateVersion = "25.11";
  # specify my home-manager configs
  home.packages = with pkgs; [
    age
  #  curl - moved to homebrew due to errors with curl-impersonate
    fd
    helix
    less
    lsd
  #  neofetch
    fastfetch
    neovim
    python3
    procs
    ripgrep
    tealdeer
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
    package = pkgs.direnv.overrideAttrs (old: { doCheck = false; });
    nix-direnv = {
      enable = true;
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
  home.file.".config/ghostty/config".source=./dotfiles/ghostty;
  home.file.".config/nvim/init.vim".source = ./dotfiles/nvim.rc;
  home.file.".config/nvim/init.lua".source=./dotfiles/nvim-plugins.lua;
  home.file.".config/powershell/Microsoft.PowerShell_profile.ps1".source=./pwsh/Microsoft.PowerShell_profile.ps1;
  home.file.".config/powershell/modules_aws.txt".source=./pwsh/modules_aws.txt;
  home.file.".config/powershell/modules.txt".source=./pwsh/modules.txt;
  home.file.".config/zellij/config.kdl".source=./dotfiles/zellij.kdl;
  home.file.".inputrc".source = ./dotfiles/inputrc;
  home.file.".config/direnv/direnvrc".source = ./dotfiles/direnvrc;
  home.file.".config/starship.toml".source = ./dotfiles/starship.toml; # zsh-prompt-evolution: replaces p10k
  home.file.".config/zsh/.zsh_plugins.txt".source = ./dotfiles/zsh_plugins.txt; # zsh-prompt-evolution: antidote bundle
  home.file.".config/geany/colorschemes/retro.config".source = ./dotfiles/retro.conf;
  home.file.".config/geany/geany.conf".source = ./dotfiles/geany.conf;
  home.file.".config/helix/config.toml".source = ./dotfiles/helix.toml;
  home.file.".config/ohmyposh/ohmyposh-nu.json".source = ./dotfiles/ohmyposh-nu.json;
  home.file.".claude/settings.json".source = ./dotfiles/claude-settings.json;
  home.file.".claude/statusline.sh".source = ./claude/statusline.sh;
  home.file.".claude/skills".source = ./claude/skills;
}