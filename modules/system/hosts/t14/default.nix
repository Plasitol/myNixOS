{ ... }:
{
  imports = [
    ./hardware.nix
    # драйверы под Intel iGPU можно добавить сюда позже, если понадобится
  ];

  networking.hostName = "t14";
  hardware.facter.reportPath = ./facter.json;
}
