{ pkgs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu;
    };
  };
  programs.virt-manager.enable = true;

}
