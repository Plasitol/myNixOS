{ pkgs, config, ... }:
let
  vpnToggle = pkgs.writeShellScriptBin "vpn-toggle" ''
    export PATH=${pkgs.libnotify}/bin:$PATH
    STATUS=$(systemctl is-active sing-box)
    if [ "$STATUS" = "active" ]; then
      pkexec systemctl stop sing-box
      notify-send "VPN Disconnected" "sing-box stopped" -i network-vpn-disconnected -u normal
    else
      pkexec systemctl start sing-box
      sleep 1
      if systemctl is-active --quiet sing-box; then
          notify-send "VPN Connected" "sing-box started" -i network-vpn -u normal
      else
          notify-send "VPN Error" "Failed to start sing-box" -i dialog-error -u critical
      fi
    fi
  '';

  vpnStatus = pkgs.writeShellScriptBin "vpn-status" ''
    if systemctl is-active --quiet sing-box; then
      echo '{"text": "VPN", "class": "connected", "tooltip": "Connected"}'
    else
      echo '{"text": "VPN", "class": "disconnected", "tooltip": "Disconnected"}'
    fi
  '';

  vpnCheck = pkgs.writeShellScriptBin "vpn-check" ''
    if systemctl is-active --quiet sing-box; then
      echo "ON"
    else
      echo "OFF"
    fi
  '';

  vpnWidget = pkgs.writeShellScriptBin "vpn-widget" ''
    #!/usr/bin/env bash
    export PATH=${pkgs.libnotify}/bin:$PATH

    get_status() {
      if systemctl is-active --quiet sing-box; then
        echo '{"text": "V", "class": "vpn-connected", "tooltip": "VPN: Connected"}'
      else
        echo '{"text": "V", "class": "vpn-disconnected", "tooltip": "VPN: Disconnected"}'
      fi
    }

    case "$1" in
      toggle)
        STATUS=$(systemctl is-active sing-box)
        if [ "$STATUS" = "active" ]; then
          pkexec systemctl stop sing-box
          notify-send "VPN Disconnected" "sing-box stopped" -i network-vpn-disconnected -u normal
        else
          pkexec systemctl start sing-box
          sleep 1
          if systemctl is-active --quiet sing-box; then
            notify-send "VPN Connected" "sing-box started" -i network-vpn -u normal
          else
            notify-send "VPN Error" "Failed to start sing-box" -i dialog-error -u critical
          fi
        fi
        get_status
        ;;
      *)
        get_status
        ;;
    esac
  '';

  vpnIndicator = pkgs.writeShellScriptBin "vpn-indicator" ''
    if systemctl is-active --quiet sing-box; then
      echo "  *  "
    else
      echo "  !  "
    fi
  '';
in
{
  environment.systemPackages = [
    vpnToggle
    vpnStatus
    vpnCheck
    vpnWidget
    vpnIndicator
    pkgs.libnotify
  ];

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.systemd1.manage-units" &&
          action.lookup("unit") == "sing-box.service" &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';
}
