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
      gvfs = pkgs.fetchFromGitHub {
        owner = "boydaihungst";
        repo = "gvfs.yazi";
        rev = "master";
        hash = "sha256-NCFdSNqSqrcbFsp8osnDhbzY2p2CyF5hzxQ1qG3TXwc=";
      };

      yamb = pkgs.fetchFromGitHub {
        owner = "h-hg";
        repo = "yamb.yazi";
        rev = "main";
        hash = "sha256-pbwKj4NuIiBMyuRVtbOYWBREZbyg1mKLoCWIAkxrygc=";
      };
    };

    # Инициализация плагина yamb в init.lua
    initLua = ''
      require("yamb"):setup {
        -- Вы можете переопределить путь к файлу с закладками (по умолчанию ~/.config/yazi/state/bookmark)
        -- path = os.getenv("HOME") .. "/.config/yazi/state/bookmark",
      }
    '';

    keymap = {
      mgr.prepend_keymap = [
        # ---------------- Drag & drop (ripdrag) ----------------
        {
          on = [ "<A-e>" ];
          run = ''shell 'ripdrag --icon-size 64 "$@"' --orphan'';
          desc = "Drag out (в Chrome/Zed/куда угодно)";
        }
        {
          on = [ "<A-i>" ];
          run = ''shell 'ripdrag --target --and-exit --icon-size 64 "$@" | while read -r f; do cp -nR -- "$f" .; done' --orphan'';
          desc = "Принять файл, перетащенный извне, в текущую папку";
        }

        # ---------------- Разное ----------------
        {
          on = [ "z" ];
          run = ''shell 'zeditor "$@"' --orphan'';
          desc = "Открыть выделенное в Zed";
        }

        # ---------------- Локальные точки монтирования ----------------
        {
          on   = [ "g" "m" ];
          run  = "cd /run/media";
          desc = "Перейти к смонтированным флешкам (Go to Media)";
        }
        {
          on   = [ "g" "n" ];
          run  = ''shell 'ya emit cd "/run/user/$(id -u)/gvfs"' --block'';
          desc = "Перейти к папке со всеми точками монтирования gvfs";
        }

        # ---------------- Сетевые шары (gvfs.yazi) ----------------
        {
          on = [ "M" ];
          run = "plugin gvfs -- select-then-mount --jump";
          desc = "GVFS: смонтировать сохранённый/новый адрес и перейти";
        }
        {
          on = [ "g" "b" ];
          run = "plugin gvfs -- add-mount";
          desc = "GVFS: добавить новый SMB/SFTP/FTP/NFS адрес";
        }
        {
          on = [ "g" "U" ];
          run = "plugin gvfs -- select-then-unmount --eject";
          desc = "GVFS: размонтировать и извлечь";
        }
        {
          on = [ "g" "p" ];
          run = "plugin gvfs -- jump-back-prev-cwd";
          desc = "GVFS: вернуться в папку, откуда перешли на шару";
        }

        # ---------------- Закладки (yamb) ----------------
        {
          on = [ "u" "a" ];
          run = "plugin yamb -- save";
          desc = "Закладки: добавить текущую папку";
        }
        {
          on = [ "u" "g" ];
          run = "plugin yamb -- jump_by_key";
          desc = "Закладки: перейти по клавише";
        }
        {
          on = [ "u" "G" ];
          run = "plugin yamb -- jump_by_fzf";
          desc = "Закладки: перейти через fzf";
        }
        {
          on = [ "u" "d" ];
          run = "plugin yamb -- delete";
          desc = "Закладки: удалить";
        }
      ];
    };

    settings = {
      yazi = {
        ratio = [ 1 4 3 ];
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
        ueberzug_offset = [ 0 0 0 0 ];
      };
      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
      };
      plugin = {
        prepend_previewers = [
          {
            url = "/run/user/*/gvfs/**/*";
            run = "noop";
          }
        ];
        prepend_preloaders = [
          {
            url = "/run/user/*/gvfs/**/*";
            run = "noop";
          }
        ];
      };
    };
  };
}
