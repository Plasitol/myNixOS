{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    pkgs.pantum-driver
  ];

  services.printing = {
    enable = true;
    drivers = [ pkgs.pantum-driver ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
