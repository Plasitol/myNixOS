{ config, pkgs, unstable, self, inputs, lib, ... }:
{
  imports = [
    ./programs
  ];

  home.username = "plasitol";
  home.homeDirectory = lib.mkForce "/home/plasitol";
  home.stateVersion = "25.05";

  services.udiskie.enable = true;

  programs.git = {
    enable = true;
    settings.user = {
      Name = "plasitol";
      Email = "daniilleimovich@gmail.com";
    };
  };
}
