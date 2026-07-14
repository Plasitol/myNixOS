{ config, pkgs, ... }:
{
  xdg.desktopEntries.yazi = {
    name = "Yazi";
    genericName = "Terminal File Manager";
    exec = "alacritty -e yazi %f";
    terminal = false;
    type = "Application";
    mimeType = [ "inode/directory" ];
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications."inode/directory" = [ "yazi.desktop" ];
  };

  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    default_dir=$HOME
    env=TERMCMD='alacritty -e'
    env=PATH=$PATH:/run/current-system/sw/bin
    open_mode=suggested
    save_mode=last
  '';

  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    org.freedesktop.impl.portal.FileChooser=termfilechooser
  '';

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    enableZshIntegration = true;
    plugins = {
      drag = pkgs.yaziPlugins.drag;
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "<A-e>" ];
          run = ''shell 'ripdrag --icon-size 64 "$@"' --orphan'';
          desc = "Drag out (в Chrome/Zed/куда угодно)";
        }
        {
          on = [ "<A-i>" ];
          run = ''shell 'ripdrag --target --and-exit --icon-size 64 "$@" | while read -r f; do cp -nR -- "$f" .; done' --block'';
          desc = "Принять файл, перетащенный извне, в текущую папку";
        }
        {
          on = [ "z" ];
          run = ''shell 'zeditor "$@"' --orphan'';
          desc = "Открыть выделенное в Zed";
        }
        {
          on = [ "<C-y>" ];
          run = ''shell 'ripdrag --target --and-exit --icon-size 64 "$@" | while read -r f; do cp -nR -- "$f" .; done' --orphan'';
          desc = "Drag & copy in (в фоне)";
        }
        {
          on   = [ "g" "m" ];
          run  = "cd /run/media";
          desc = "Перейти к смонтированным флешкам (Go to Media)";
        }
      ];
    };
    settings = {
      yazi = {
        ratio = [
          1
          4
          3
        ];
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
      };
      opener = {
         edit = [ {
           run = "micro %s";
           block = true;
         } ];
      };
      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 1;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        ueberzug_scale = 1;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };
      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
      };
    };
  };
}
