{ pkgs, ... }: {
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        # zsh-prompt-evolution: autosuggestions + syntax-highlighting come from
        # the antidote bundle below instead, so the plugin isn't loaded twice.
        autosuggestion.enable = false;
        syntaxHighlighting.enable = false;

        profileExtra = ''
          eval "$(/opt/homebrew/bin/brew shellenv)"
        '';

        initContent = ''
        eval "$(zellij setup --generate-auto-start zsh)"
        [[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

        zstyle ':completion:*' matcher-list "" 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

        # zsh-prompt-evolution: antidote replaces oh-my-zsh / powerlevel10k
        # (mirrors amatarsu's tested setup, applied via Ungyo-nix first).
        export ZSH_CACHE_DIR="$HOME/.cache/zsh"
        mkdir -p "$ZSH_CACHE_DIR/completions"
        source "$(brew --prefix antidote)/share/antidote/antidote.zsh"
        antidote load "$HOME/.config/zsh/.zsh_plugins.txt"

        setopt correct

        # zsh-prompt-evolution: starship replaces powerlevel10k
        eval "$(starship init zsh)"
        ''; # Init Zellij, cargo, antidote plugins, starship prompt, case-insensitive tab completion

        shellAliases = {
            brewup = "brew update && brew upgrade && brew cleanup --prune=all";
            cat = "bat";
            cd = "z";
            explorer = "open";  
            find = "fd";
            la = "lsd -la";
            ll = "lsd -l";
            ls = "lsd";
            nixswitch = "darwin-rebuild switch --flake ~/src/Toyotama-Nix/.#";
            nixup = "brewup; pushd ~/src/Toyotama-Nix; ./modules/home-manager/scripts/nixup.sh; popd"; #testing
            nixclean = "nix-store --gc"; # Clean local nix store
            powershell = "pwsh";
            ps = "procs";    
            ssh = "TERM=xterm-256color /usr/bin/ssh"; # fix for alacritty and ghostty
            vi = "hx"; # Alias Helix to open in place of vi
        };
    };
}