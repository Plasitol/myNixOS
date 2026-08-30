{ pkgs, unstable, config, ... }:
let
  c = config.lib.stylix.colors;

  svgWallpaper = pkgs.writeText "nixos-wallpaper.svg" ''
  <svg xmlns="http://www.w3.org/2000/svg" width="2560" height="1440" viewBox="0 0 2560 1440">
    <rect width="100%" height="100%" fill="#${c.base00}"/>
    <g transform="translate(1280,720) scale(32) translate(-12,-12)">
      <path fill="#${c.base0D}" d="M7.352 1.592l-1.364.002L5.32 2.75l1.557 2.713-3.137-.008-1.32 2.34H14.11l-1.353-2.332-3.192-.006-2.214-3.865z"/>
      <path fill="#${c.base0C}" d="M13.527 1.592l-2.687.025 5.846 10.127 1.341-2.34-1.59-2.765 2.24-3.85-.683-1.182h-1.336l-1.57 2.705-1.56-2.72z"/>
      <path fill="#${c.base0D}" d="M20.414 5.787l-5.846 10.125 2.696-.008 1.601-2.76 4.453.016.682-1.183-.666-1.157-3.13-.008L21.778 8.1l-1.365-2.313z"/>
      <path fill="#${c.base0C}" d="M9.432 8.086l-2.696.008-1.601 2.76-4.453-.016L0 12.02l.666 1.157 3.13.008-1.575 2.71 1.365 2.315L9.432 8.086z"/>
      <path fill="#${c.base0D}" d="M7.33 12.25l-.006.01-.002-.004-1.342 2.34 1.59 2.765-2.24 3.85.684 1.182H7.35l.004-.006h.001l1.567-2.698 1.558 2.72 2.688-.026-.004-.006h.01L7.33 12.25z"/>
      <path fill="#${c.base0C}" d="M9.881 16.008l1.354 2.332 3.192.006 2.215 3.865 1.363-.002.668-1.156-1.557-2.713 3.137.008 1.32-2.34H9.881Z"/>
    </g>
  </svg>

  '';

  compiledWallpaper = pkgs.runCommand "nixos-wallpaper.png" {
    nativeBuildInputs = [ pkgs.resvg ];
  } ''
    resvg --width 2560 --height 1440 ${svgWallpaper} $out
  '';
in
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    image = compiledWallpaper;

    targets = {
      gtk.enable = true;
      qt.enable = true;
    };

    fonts = {
      serif = {
        package = unstable.ubuntu-sans-mono;
        name = "Ubuntu Sans Mono";
      };
      sansSerif = {
        package = unstable.ubuntu-sans;
        name = "Ubuntu Sans";
      };
      monospace = {
        package = unstable.ubuntu-sans-mono;
        name = "Ubuntu Sans Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
