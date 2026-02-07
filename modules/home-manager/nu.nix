{ ... }: {
    programs = {
        nushell = { 
          enable = true;
          configFile.source = ./dotfiles/config.nu;
        };
    };
}