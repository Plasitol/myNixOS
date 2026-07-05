{ pkgs, config, ... }:
{
  imports = [
    ./settings.nix
  ];
  programs.zed-editor = {
    enable = true;
  };
}
