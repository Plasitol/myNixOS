{ pkgs, ... }:
{
  stylix = {
  	enable = true;
  	autoEnable = true;

  	cursor = {
  		package = pkgs.apple-cursor;
  		name = "macOS";
  		size = 24;
  	};

  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-nord; # { color = "indigo"; };
#      dark = "Papirus-Dark"; # used
#      light = "Papirus-Light"; # unused
    };
    gtk3.bookmarks = [
      "file:///home/plasitol/Documents"
      "file:///home/plasitol/Downloads"
      "file:///home/plasitol/Pictures"
      "file:///home/plasitol/Videos"
      "file:///home/plasitol/Music"
      "file:///etc/nixos"
    ];
  };

  qt.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg.configFile."gtk-3.0/settings.ini".text = ''
    gtk-application-prefer-dark-theme=true
  '';
  xdg.configFile."gtk-4.0/settings.ini".text = ''
    gtk-application-prefer-dark-theme=true
  '';
}
