{ ... }:
{
  imports = [
    ./hardware.nix
    ../../drivers/nvidia.nix
  ];

  networking.hostName = "station";
  hardware.facter.reportPath = ./facter.json;
}
