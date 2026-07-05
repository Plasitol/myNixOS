{ config, pkgs, lib, ... }:
let
  c = config.lib.stylix.colors;
in
{
  programs.tofi = lib.mkForce {
    enable = true;
    settings = {
      border-width = 0;
      background-color = "#${c.base00}BF";
      prompt-color = "#${c.base03}";
      selection-color = "#${c.base0D}";
      height = "100%";
      num-results = 5;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      width = "100%";
    };
  };
}
