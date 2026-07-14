{ config, pkgs, ... }:
let
  c = config.lib.stylix.colors;
in
{
  programs.ironbar = {
    enable = true;

    config = {
      position = "bottom";
      height = 30;
      margin.bottom = 0;

      start = [
		  {
		    type = "workspaces";
		    # favorites = [ "1" "2" "3" "4" "5" ];
		    all_monitors = false;
		    name_map = { "1" = "a"; "2" = "b"; "3" = "c"; "4" = "d"; "5" = "e"; "6" = "f"; "7" = "g"; "8" = "h"; "9" = "i";};
		  }
      ];

      center = [
      {
        type = "tray";
        icon_size = 16;
        on_click_left = "menu";
        on_click_left_double = "default";
      }
      #{
      #  type = "launcher";
      #  show_names = false;
      #  show_icons = true;
      #  reversed = false;
      #}
      ];

      end = [
       # {
       #   type = "script";
       #   name = "vpn";
       #   mode = "poll";
       #   interval = 2000;
       #   cmd = "vpn-indicator";
       #   on_click_left = "vpn-toggle";
       # }
        {
          type = "clock";
          name = "clock";
          format = "%d-%m   %H:%M";
          format_popup = "%d.%m.%Y %H:%M";
        }
        {
          type = "volume";
          name = "volume";
          format = "{percentage}%";
          max_volume = 100;
        }
      ];
    };

    style = ''
      * {
        font-size: 14px;
        border: none;
        border-radius: 0;
        padding: 0;
        margin: 0;
      }

      .bar {
        background-color: #${c.base00};
        color: #${c.base05};
        box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.4);
      }

      .workspaces .item {
        padding: 0 6px;
        color: #${c.base03};
        background: transparent;
        transition: color 0.2s ease;
      }

      .workspaces .item.focused {
        background: #${c.base0D};
        color: #${c.base00};
        font-weight: bold;
      }

      .workspaces .item:hover {
        color: #${c.base05};
      }

      .tray, .launcher {
        padding: 0 12px;
      }

      .clock {
        color: #${c.base04};
        padding: 0 16px;
        font-weight: 500;
        letter-spacing: 0.5px;
      }

      .sysinfo {
        padding: 0 12px;
        color: #${c.base04};
        font-size: 13px;
      }

      .launcher .item {
        margin: 0 4px;
      }

      .sysinfo label {
        margin-left: 10px;
      }

      .volume {
        padding: 0 16px;
        color: #${c.base04};
      }

      .volume.muted {
        color: #${c.base03};
      }

      .vpn {
        padding: 0 10px;
        font-weight: 700;
        color: #${c.base0B};
      }
      .vpn.disconnected {
        color: #${c.base08};
      }
    '';
  };
}
