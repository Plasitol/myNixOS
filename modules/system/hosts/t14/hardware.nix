{ lib, ... }:
{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b53319a4-fb12-443f-8055-488c951cf494";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0990-8889";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/7e364229-c307-4d04-8f59-5dd6e908b49b";
      options = [ "nofail" "x-systemd.device-timeout=10s" ]; }
  ];

  mySystem.resumeDevice = "/dev/disk/by-uuid/7e364229-c307-4d04-8f59-5dd6e908b49b";

  networking.useDHCP = lib.mkDefault true;
}

