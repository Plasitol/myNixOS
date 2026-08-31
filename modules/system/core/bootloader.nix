{ config, lib, pkgs, ... }:
{
  options.mySystem.resumeDevice = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "UUID of swap hibernation";
  };
  config = lib.mkMerge [
    {
       # Bootloader.
       boot.kernelPackages = pkgs.linuxPackages_zen;
       boot.loader.systemd-boot.configurationLimit = 5;
       boot.loader.systemd-boot.enable = true;
       boot.loader.efi.canTouchEfiVariables = true;
       # boot.kernelPackages = pkgs.linuxPackages_latest;
    }
    (lib.mkIf (config.mySystem.resumeDevice != null) {	# Hibernation.
      boot.resumeDevice = config.mySystem.resumeDevice;
      boot.kernelParams = [ "resume=${config.mySystem.resumeDevice}" ];
    })
  ];
}
