{ pkgs, ... }:
{
  # Bootloader.
	boot.kernelPackages = pkgs.linuxPackages_zen;
	boot.loader.systemd-boot.configurationLimit = 5;
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	# boot.kernelPackages = pkgs.linuxPackages_latest;
}
