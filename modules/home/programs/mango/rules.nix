{ ... }:
{
  wayland.windowManager.mango.settings = {

    # -----------------------------------------------------------------------
    # Tag rules — ставим раскладку scroller на все 9 тегов, чтобы поведение
    # было максимально похоже на scrollable-tiling niri.
    # (в оригинальном niri-конфиге отдельных per-workspace правил не было —
    # ты, судя по всему, просто плыл на дефолтной раскладке niri)
    # -----------------------------------------------------------------------
    tagrule = [
      "id:1,layout_name:dwindle"
      "id:2,layout_name:dwindle"
      "id:3,layout_name:dwindle"
      "id:4,layout_name:dwindle"
      "id:5,layout_name:dwindle"
      "id:6,layout_name:dwindle"
      "id:7,layout_name:dwindle"
      "id:8,layout_name:dwindle"
      "id:9,layout_name:dwindle"
    ];
    # -----------------------------------------------------------------------
    # Window rules
    # -----------------------------------------------------------------------
    windowrule = [
      # --- niri: пустое правило на app-id="Alacritty" — не переносим, там
      # ничего не было задано, это был no-op.

      # --- niri: is-floating=true -> shadow.enable=false
      # НЕВОЗМОЖНО перенести точечно: mango не умеет матчить правила по
      # динамическому состоянию окна (is-floating), только по appid/title.
      # У тебя и так shadows=0 глобально в settings.nix, так что по факту
      # эффект тот же самый.

      # --- niri: org.telegram.desktop -> block-out-from=screencast
      # НЕТ АНАЛОГА в windowrule mango, такого параметра не нашёл.

      # --- niri: zen/firefox/chromium-browser/xdg-desktop-portal-gtk -> scroll-factor=0.5
      # НЕТ per-app аналога, только глобальный axis_scroll_factor.

      # --- niri: браузеры/мессенджеры/терминал -> opacity=1.0, open-maximized=true
      # В mango по умолчанию force_fakemaximize=1 (окна и так открываются
      # псевдо-максимизированными), так что отдельное правило не нужно.
      # Если конкретно для каких-то appid это НЕ нужно — форсим обратно так:
      #   "appid:foo,noopenmaximized:1"

      # --- niri: firefox PiP (appid+title) -> floating, фиксированная позиция/размер
      "isfloating:1,width:480,height:270,offsetx:100,offsety:100,appid:firefox,title:Picture-in-Picture"

      # --- niri: любой "Picture in picture" (без привязки к appid)
      "isfloating:1,offsetx:100,offsety:100,title:Picture in picture"

      # --- niri: "Discord Popout"
      "isfloating:1,offsetx:100,offsety:100,title:Discord Popout"

      # --- niri: список app-id -> open-floating=true
      # regex-alternation вместо отдельного правила на каждый appid
      "isfloating:1,appid:pavucontrol|nautilus|org\\.gnome\\.Nautilus|pavucontrol-qt|ark|vlc|com\\.saivert\\.pwvucontrol|dialog|popup|task_dialog|gcr-prompter|file-roller|nm-connection-editor|blueman-manager|xdg-desktop-portal-gtk|pinentry"

      # --- niri: список заголовков окон -> open-floating=true (точное совпадение)
      "isfloating:1,title:^(Progress|File Operations|Copying|Moving|Properties|Downloads|file progress|Confirm|Authentication Required|Notice|Warning|Error)$"

      # --- niri: regex-заголовки (Open/Save/.../Preferences/Settings/...)
      "isfloating:1,title:^(Open|Save|Save As.*|Open File.*|Choose.*|Select.*|Preferences|Settings|About.*|Print.*|Export.*|Import.*)$"
    ];

    # -----------------------------------------------------------------------
    # Layer rules
    # -----------------------------------------------------------------------
    layerrule = [
      # niri: layer-rules matches namespace "^noctalia-wallpaper*" — без
      # дополнительных свойств, не переносим (no-op и там был).

      # niri: "^noctalia-overview*" -> place-within-backdrop = true
      # У mango другая модель overview, такого параметра у layerrule нет —
      # если noctalia-shell рисует какой-то оверлей поверх overview-режима
      # mango, проверяй руками, возможно тут ничего и не нужно.
    ];
  };
}
