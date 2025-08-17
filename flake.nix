{
  description = "My WIP MacOS flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    #sops-nix
    sops-nix.url = "github:Mic92/sops-nix";

  };
  outputs = inputs@{ nixpkgs, home-manager, darwin, sops-nix, ... }: {
    darwinConfigurations.toyotama = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = import nixpkgs { 
        system = "aarch64-darwin";
        config.allowUnfree = true;
        };
      modules = [
        ./modules/darwin
        home-manager.darwinModules.home-manager
        sops-nix.darwinModules.sops
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.justin.imports = [ ./modules/home-manager ];
          };
        }
      ];
    };
  };
}
