{
  description = "plasitol's NixOS systems";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zapret = {
      url = "github:kartavkun/zapret-discord-youtube";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ironbar = {
      url = "github:JakeStanger/ironbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kompas-3d = {
      url = "github:Plasitol/Kompas3D-v24-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      stylix,
      zapret,
      niri-flake,
      helium,
      ironbar,
      sops-nix,
      kompas-3d,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      mkHost = hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # host-specific: hostName, facter.json, драйверы, диски
            ./modules/system/hosts/${hostname}

            { nixpkgs.overlays = [
                niri-flake.overlays.niri
                inputs.helium.overlays.default
              ];
            }
            niri-flake.nixosModules.niri
            kompas-3d.nixosModules.grdcontrol

            # НЕБЕЗОПАСНО
            { nixpkgs.config.permittedInsecurePackages = [
                "pnpm-9.15.9"
              ];
            }

            ({ pkgs, ... }: {
              programs.niri.enable = true;
              environment.systemPackages = [ kompas-3d.packages.${system}.kompas3d ];
            })

            stylix.nixosModules.stylix
            zapret.nixosModules.withTestTools
            sops-nix.nixosModules.sops

            ./modules/system/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit self inputs unstable;
              };
              home-manager.users.plasitol = import ./modules/home/home.nix;
              home-manager.sharedModules = [
                ironbar.homeManagerModules.default
                sops-nix.homeManagerModules.sops
              ];
            }
          ];
          specialArgs = { inherit unstable inputs; };
        };
    in
    {
      nixosConfigurations.station = mkHost "station";
      nixosConfigurations.t14 = mkHost "t14";
    };
}
