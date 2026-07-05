{ pkgs, inputs, ... }:
{
  imports = [
    ./binds.nix
    ./settings.nix
    ./rules.nix
  ];

  programs.niri.package = pkgs.niri;
}
