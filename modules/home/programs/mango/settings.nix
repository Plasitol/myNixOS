{ pkgs, config, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  wayland.windowManager.mango.settings = {

    # ---------------------------------------------------------------------
    # Appearance / gaps / border
    # (niri: layout.gaps = 0; layout.focus-ring; layout.border; layout.shadow)
    # ---------------------------------------------------------------------
    gappih = 0;
    gappiv = 0;
    gappoh = 0;
    gappov = 0;

    borderpx = 1;
    # У mango нет отдельного слоя "focus-ring" поверх "border" как в niri —
    # это одно и то же понятие, поэтому active/inactive/urgent цвета отсюда:
    bordercolor  = "0x505050ff";        # niri: focus-ring/border inactive.color
    focuscolor   = "0x${colors.base0E}ff"; # niri: focus-ring/border active.color
    urgentcolor  = "0x9b0000ff";        # niri: border.urgent.color

    # niri: shadow.enable = false
    shadows = 0;

    # Курсор — прямое совпадение с niri cursor.theme / cursor.size
    cursor_theme = config.stylix.cursor.name;
    cursor_size  = config.stylix.cursor.size;

    # niri: gestures.hot-corners.enable = false
    enable_hotarea = 0;

    dwindle_split_ratio       = 0.5;   # ratio нового сплита
    dwindle_smart_split       = 1;     # направление сплита по пропорциям окна
    dwindle_preserve_split    = 1;     # сохранять точку раздела при закрытии окна
    dwindle_smart_resize      = 1;     # умный ресайз соседей
    dwindle_drop_simple_split = 1;

    circle_layout = "dwindle,tile,scroller,monocle,grid"; # порядок для switch_layout

    # ---------------------------------------------------------------------
    # Animations (niri: animations.slowdown = 1.9 — в mango нет общего
    # множителя, поэтому дефолтные длительности домножены на ~1.9 вручную.
    # Крути под себя.)
    # ---------------------------------------------------------------------

    animations = 1;                 # или 0, если хочешь совсем без анимаций
    # layer_animations = 0;
    animation_type_open  = "fade";
    animation_type_close = "fade";
    layer_animation_type_open  = "fade";
    layer_animation_type_close = "fade";

    animation_duration_open  = 120;
    animation_duration_close = 120;
    animation_duration_move  = 100;
    animation_duration_tag   = 100;

    animation_fade_in  = 1;
    animation_fade_out = 1;
    fadein_begin_opacity  = 0.85;   # чем ближе к 1.0, тем незаметнее fade
    fadeout_begin_opacity = 0.85;

    # ---------------------------------------------------------------------
    # Layout defaults — аналог niri layout.default-column-width /
    # preset-column-widths. Раскладку scroller на все теги ставим в rules.nix.
    # ---------------------------------------------------------------------
    default_mfact = 0.5;
    scroller_default_proportion  = 0.5;   # niri default-column-width proportion
    scroller_proportion_preset   = "0.33333,0.5,0.66667"; # niri preset-column-widths
    scroller_structs = 0;

    # ---------------------------------------------------------------------
    # Keyboard (niri: input.keyboard.xkb / numlock)
    # ---------------------------------------------------------------------
    xkb_rules_layout  = "us,ru";
    xkb_rules_options = "grp:alt_shift_toggle";
    numlockon = 1;

    # ---------------------------------------------------------------------
    # Touchpad (niri: input.touchpad)
    # ---------------------------------------------------------------------
    tap_to_click = 1;
    trackpad_natural_scrolling = 1;

    # У niri было input.mouse.enable и input.trackpoint.enable — в mango нет
    # отдельных тумблеров под них, мышь/трекпоинт работают всегда как обычные
    # pointer-устройства через libinput.

    # ---------------------------------------------------------------------
    # Environment variables (niri: environment = { ... };)
    # Повторяемый ключ, как bind/tagrule — каждая строка списка это одна
    # директива `env=` в итоговом config.conf.
    # ---------------------------------------------------------------------
    env = [
      "XDG_CURRENT_DESKTOP,mango"
      "XDG_SESSION_DESKTOP,mango"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "QS_ICON_THEME,Papirus"
      "XCURSOR_THEME,${config.stylix.cursor.name}"
      "XCURSOR_SIZE,${toString config.stylix.cursor.size}"
      # SSH_AUTH_SOCK и DISPLAY в niri задавались тут же — в принципе можно
      # так же, но обычно их лучше прокидывать через systemd user environment
      # (см. wayland.windowManager.mango.systemd.variables в nix-options).
      "SSH_AUTH_SOCK,/run/user/1000/keyring/ssh"
    ];
  };

  # -------------------------------------------------------------------------
  # Autostart (niri: layout.spawn-at-startup)
  # xwayland-satellite убран — mango поднимает Xwayland сам, см. 00-README.md
  # -------------------------------------------------------------------------
  wayland.windowManager.mango.autostart_sh = ''
    ${pkgs.polkit_gnome}/bin/polkit-gnome-authentication-agent-1 &
    ironbar &
    wl-paste --type text --watch cliphist store &
    wl-paste --type image --watch cliphist store &
    awww-daemon &
    ${pkgs.awww}/bin/awww img ${config.stylix.image} &
  '';

  # screenshot-path в mango нет как отдельной опции — путь сохранения
  # прописывается прямо в команде grim в binds.nix (bind Mod+Shift+S).
}
