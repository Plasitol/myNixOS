{ lib, ... }:
{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/74371cb1-8d0e-48e3-a965-646b641391aa";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EF03-A110";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/32303a08-6fcd-458a-9aeb-9332338eec61";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/9489a728-d39c-47d4-a2fb-fbf0a1489731"; }
  ];

  networking.useDHCP = lib.mkDefault true;
}
