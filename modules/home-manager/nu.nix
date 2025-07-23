{inputs, config, pkgs, ...}: {
    programs = {
      nushell = { 
        enable = true;
        configFile.source = "./dotfiles/config.nu"; #testing to avoid impure path issues
        };
    };
}