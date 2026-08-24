{inputs, config, pkgs, ...}: {
    programs.tmux ={
        enable = true;
        shell = "${pkgs.zsh}/bin/zsh";
        terminal = "screen-256color";
        historyLimit = 5000;
        clock24 = true;
        package = pkgs.tmux.overrideAttrs (old: {
            configureFlags = (old.configureFlags or []) ++ ["--disable-jemalloc"];
        });
        plugins = with pkgs;
        [
            tmuxPlugins.better-mouse-mode
        ];

    };
}