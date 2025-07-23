{inputs, config, pkgs, ...}: {
    programs = {
        nushell = { 
          enable = true;
          configFile.source = ./dotfiles/config.nu;
        };
        ohmyposh = {
          enable = true;
          enableNushellIntegration = true;
#          settings = ./dotfiles/ohmyposh.json
        };
    };
}