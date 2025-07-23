{inputs, config, pkgs, ...}: {
    programs = {
    nushell = { enable = true;
      configFile.source = /Users/justin/.config/nushell/config.nu --impure;
        };
    };
}