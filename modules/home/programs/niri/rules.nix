{
  programs.niri = {
    settings = {
      layer-rules = [
        { matches = [ { namespace = "^noctalia-wallpaper*"; } ]; }
        {
          matches = [ { namespace = "^noctalia-overview*"; } ];
          place-within-backdrop = true;
        }
      ];

      window-rules = [
        {
          opacity = 1.0;
          draw-border-with-background = false;

          focus-ring = {
            width = 1;
          };

         # geometry-corner-radius = {
         #   bottom-left = 15.0;
         #   bottom-right = 15.0;
         #   top-left = 15.0;
         #   top-right = 15.0;
         # };
         # clip-to-geometry = true;
        }
        {
          matches = [
            {
              app-id = "Alacritty";
            }
          ];
        }
        {
          matches = [
            { is-floating = true; }
          ];
          shadow.enable = false;
        }
        {
          matches = [ { app-id = "org.telegram.desktop"; } ];
          block-out-from = "screencast";
        }
        {
          matches = [
            { app-id = "zen"; }
            { app-id = "firefox"; }
            { app-id = "chromium-browser"; }
            { app-id = "xdg-desktop-portal-gtk"; }
          ];
          scroll-factor = 0.5;
        }
        {
          matches = [
            { app-id = "zen"; }
            { app-id = "firefox"; }
            { app-id = "chromium-browser"; }
            { app-id = "edge"; }
            { app-id = "brave-browser"; }
            { app-id = "google-chrome-stable"; }
            { app-id = "google-chrome"; }
            { app-id = "org.telegram.desktop"; }
            { app-id = "vesktop"; }
            { app-id = "alacritty"; }
          ];
          opacity = 1.0;
          open-maximized = true;
        }
        {
          matches = [
            {
              app-id = "firefox";
              title = "Picture-in-Picture";
            }
          ];
          open-floating = true;
          default-floating-position = {
            x = 32;
            y = 32;
            relative-to = "bottom-right";
          };
          default-column-width = {
            fixed = 480;
          };
          default-window-height = {
            fixed = 270;
          };
        }
        {
          matches = [ { title = "Picture in picture"; } ];
          open-floating = true;
          default-floating-position = {
            x = 32;
            y = 32;
            relative-to = "bottom-right";
          };
        }
        {
          matches = [ { title = "Discord Popout"; } ];
          open-floating = true;
          default-floating-position = {
            x = 32;
            y = 32;
            relative-to = "bottom-right";
          };
        }
        {
          matches = [ { app-id = "pavucontrol"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "nautilus"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "pavucontrol-qt"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "ark"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "vlc"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "com.saivert.pwvucontrol"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "dialog"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "popup"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "task_dialog"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "gcr-prompter"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "file-roller"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "org.gnome.Nautilus"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "nm-connection-editor"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "blueman-manager"; } ];
          open-floating = true;
        }
        {
          matches = [ { app-id = "xdg-desktop-portal-gtk"; } ];
          open-floating = true;
        }
        # {
        #   matches = [ { app-id = "org.kde.polkit-kde-authentication-agent-1"; } ];
        #   open-floating = true;
        # }
        {
          matches = [ { app-id = "pinentry"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "Progress"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "File Operations"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "Copying"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "Moving"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "Properties"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "Downloads"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "file progress"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "Confirm"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "Authentication Required"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "Notice"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "Warning"; } ];
          open-floating = true;
        }
        {
          matches = [ { title = "Error"; } ];
          open-floating = true;
        }
	{
  	  matches = [
    	  { title = "^Open$"; }
    	  { title = "^Save$"; }
    	  { title = "^Save As.*"; }
    	  { title = "^Open File.*"; }
    	  { title = "^Choose.*"; }
    	  { title = "^Select.*"; }
    	  { title = "^Preferences$"; }
    	  { title = "^Settings$"; }
     	  { title = "^About.*"; }
    	  { title = "^Print.*"; }
    	  { title = "^Export.*"; }
    	  { title = "^Import.*"; }
  	];
  	open-floating = true;
	}

      ];
    };
  };
}
