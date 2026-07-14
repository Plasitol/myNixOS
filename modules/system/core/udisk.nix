{ config, pkgs, ... }:

{
  services.dbus.enable = true;
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    gvfs
    dbus
    udiskie
  ];

  services.udisks2.enable = true;
  services.devmon.enable = true;
}
