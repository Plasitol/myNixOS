{
  description = "plasitol's NixOS desktop";

  inputs = {
  # стейбла
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

  # айнстеблы
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
  };

  outputs = {

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
  ...

  }@inputs:
    let
      system = "x86_64-linux";

      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          # Аппаратный детект через nixos-facter вместо hardware-configuration.nix
          { config.hardware.facter.reportPath = ./modules/system/core/facter.json; }

          # Системная часть niri: ставит бинарник, регистрирует Wayland-сессию
          # у greetd, поднимает polkit/keyring. Без этого модуля композитор
          # не появится в списке сессий на логин-экране.
		  { nixpkgs.overlays = [
		    niri-flake.overlays.niri
		    inputs.helium.overlays.default
		    ]; }
		  niri-flake.nixosModules.niri

		  ({ pkgs, ... }: {
		   programs.niri.enable = true;
		   #programs.niri.package = pkgs.niri-unstable; #stable/unstable ветка
		  })

          stylix.nixosModules.stylix

          zapret.nixosModules.default
          #zapret.nixosModules.withTestTools

          sops-nix.nixosModules.sops

          ./modules/system/configuration.nix
          ./modules/system/hardware.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit self;
              inherit inputs;
              inherit unstable;
            };
            home-manager.users.plasitol = import ./modules/home/home.nix;

            home-manager.sharedModules = [
              ironbar.homeManagerModules.default
              sops-nix.homeManagerModules.sops
            ];
          }
        ];
        specialArgs = {
          inherit unstable;
          inherit inputs;
        };
      };
    };
}
