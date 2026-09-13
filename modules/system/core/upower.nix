{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brightnessctl
    powertop
  ];

  services.upower = {
    enable = true;
    percentageLow = 15;
    percentageCritical = 5;
  };
}
