{inputs, config, pkgs, ...}: {
    programs = {
    nushell = { enable = true;
      configFile.source = ~/.config/nushell/config.nu;
        };
    };
}