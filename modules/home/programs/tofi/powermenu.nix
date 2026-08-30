{ pkgs, ... }:
let
  powermenu = pkgs.writeShellScriptBin "tofi-powermenu" ''
    set -euo pipefail

    choice=$(printf '%s\n' "Lock" "Logout" "Reboot" "Shutdown" "Hibernate" \
      | ${pkgs.tofi}/bin/tofi --prompt-text "" )

    case "$choice" in
      Lock)     ${pkgs.hyprlock}/bin/hyprlock ;;
      Logout)   niri msg action quit ;;
      Reboot)   systemctl reboot ;;
      Shutdown) systemctl poweroff ;;
      Hibernate) systemctl hibernate ;;
      *)        exit 0 ;;
    esac
  '';
in
{
  home.packages = [ powermenu ];
}
