{inputs, config, pkgs, ...}: {
    programs = {
        nushell = { 
          enable = true;
          configFile.source = ./dotfiles/config.nu;
        };
        oh-my-posh = {
          enable = true;
          enableNushellIntegration = true;                   
        };
    };
}