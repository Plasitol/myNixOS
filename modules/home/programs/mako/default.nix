{ config, pkgs, ...}: {
  services.mako = {
    enable = true;
    settings = {
      border-size = 2;
      border-radius = 0;
      default-timeout = 5000;
      padding = "10";
      margin = "10,10";
      anchor = "top-right";
    };
  };
}
