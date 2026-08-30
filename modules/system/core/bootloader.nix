{ pkgs, ... }:
{
  # Bootloader.
	boot.kernelPackages = pkgs.linuxPackages_zen;
	boot.loader.systemd-boot.configurationLimit = 5;
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	# boot.kernelPackages = pkgs.linuxPackages_latest;

	# Hibernation.
  boot.resumeDevice = "/dev/disk/by-uuid/9489a728-d39c-47d4-a2fb-fbf0a1489731";
  boot.kernelParams = [
    "resume=/dev/disk/by-uuid/9489a728-d39c-47d4-a2fb-fbf0a1489731"
  ];
}
