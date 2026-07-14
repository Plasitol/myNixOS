{
  config,
  pkgs,
  lib,
  ...
}:
{
	imports = [
	  ./core
		./drivers
		./bypass
		./packages.nix
		./stylix.nix
	];

	nix.settings.experimental-features = [
	  "nix-command"
	  "flakes"
	];

	nix.gc = {
	  automatic = true;
	  dates = "weekly";
	  options = "--delete-older-than 14d";
	};

	#Direnv
	programs.direnv = {
	  enable = true;
	  nix-direnv.enable = true;
	  enableZshIntegration = true;
	};

	networking.hostName = "station";
	networking.networkmanager.enable = true;

	time.timeZone = "Europe/Moscow";

	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
	  LC_ADDRESS = "ru_RU.UTF-8";
	  LC_IDENTIFICATION = "ru_RU.UTF-8";
	  LC_MEASUREMENT = "ru_RU.UTF-8";
	  LC_MONETARY = "ru_RU.UTF-8";
	  LC_NAME = "ru_RU.UTF-8";
	  LC_NUMERIC = "ru_RU.UTF-8";
	  LC_PAPER = "ru_RU.UTF-8";
	  LC_TELEPHONE = "ru_RU.UTF-8";
	  LC_TIME = "ru_RU.UTF-8";
	};

	services.xserver.xkb = {
	  layout = "us";
	  variant = "";
	};

	nixpkgs.config.allowUnfree = true;

	nix.extraOptions = "warn-dirty = false";

	sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

	systemd.services.NetworkManager-wait-online.enable = false;
	services.auto-cpufreq.enable = true;
	services.thermald.enable = true;

	system.stateVersion = "25.05";
}
