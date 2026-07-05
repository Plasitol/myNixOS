{ pkgs, lib, config, ... }:

let
  username = "plasitol";
in
{
  services.xserver.enable = true;

  services.displayManager.gdm = {
    enable = true;
  };

  services.displayManager.defaultSession = "niri";

  stylix.targets.gnome.enable = true;
}
