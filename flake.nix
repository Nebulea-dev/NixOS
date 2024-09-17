{
  description = "My Home Manager and NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flatpaks.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, flatpaks, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          # make unstable packages available via overlay
          (final: prev: {
            unstable = nixpkgs-unstable.legacyPackages.${prev.system};
          })
        ];
      };
    in {
      # NixOS configuration
      nixosConfigurations = {
        lea = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
          ];
        };
      };

      # Home Manager configuration
      homeConfigurations = {
        lea = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
           
          modules = [
            ./home.nix
            ./flatpak.nix
            flatpaks.homeManagerModules.nix-flatpak
          ];
        };
      };
    };
}

