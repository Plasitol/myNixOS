{ ... }:
{
  # Предполагаю, что твой "Mod" в niri = клавиша Super. Если нет — замени
  # SUPER на ALT/CTRL везде по файлу.
  #
  # Синтаксис: bind[flags]=MODIFIERS,KEY,COMMAND,PARAMETERS
  #   флаги:  l — работает при заблокированном экране
  #           r — срабатывает на release, а не press
  #           s — матчить по keysym, а не keycode
  #           p — пробросить событие клиенту

  wayland.windowManager.mango.settings.bind = [
    # show-hotkey-overlay — в mango нет hotkey-overlay, аналога нет.

    "SUPER,Return,spawn,alacritty"
    "SUPER,W,spawn,tofi-drun --drun-launch=true"
    "SUPER,V,spawn,noctalia-shell ipc call launcher clipboard"
    "SUPER,A,spawn,noctalia-shell ipc call wallpaper toggle"
    "SUPER,P,spawn,tofi-powermenu"
    "SUPER,C,spawn,zsh -lc zeditor"
    "SUPER,E,spawn,alacritty --class nautilus -e yazi"
    "SUPER,B,spawn,google-chrome-stable"

    # maximize-column / switch-preset-column-width — ближайший аналог есть
    # только в раскладке scroller (у нас она стоит на всех тегах, см. rules.nix)
    "SUPER,F,set_proportion,1.0"          # niri: maximize-column
    "SUPER,R,switch_proportion_preset"    # niri: switch-preset-column-width
    "SUPER,T,togglefloating"              # niri: toggle-window-floating

    "SUPER+ALT,L,spawn,swaylock"

    # allow-when-locked = true -> флаг l
    "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"
    "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"
    "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    "NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

    "SUPER,O,toggleoverview"   # niri: toggle-overview (repeat=false аналога нет, не критично)
    "SUPER,Q,killclient"       # niri: close-window

    # --- Фокус между окнами/колонками (в раскладке scroller колонка ~= окно) ---
    "SUPER,Left,focusdir,left"
    "SUPER,Right,focusdir,right"
    "SUPER,Up,focusdir,up"
    "SUPER,Down,focusdir,down"
    "SUPER,H,focusdir,left"
    "SUPER,J,focusdir,down"
    "SUPER,K,focusdir,up"
    "SUPER,L,focusdir,right"

    # --- Перемещение окна (niri move-column/move-window) ---
    "SUPER+CTRL,Left,exchange_client,left"
    "SUPER+CTRL,Right,exchange_client,right"
    "SUPER+CTRL,Up,exchange_client,up"
    "SUPER+CTRL,Down,exchange_client,down"
    "SUPER+CTRL,H,exchange_client,left"
    "SUPER+CTRL,J,exchange_client,down"
    "SUPER+CTRL,K,exchange_client,up"
    "SUPER+CTRL,L,exchange_client,right"

    # focus-column-first/last, move-column-to-first/last —
    # НЕТ ПРЯМОГО АНАЛОГА в mango, диспетчера под "первая/последняя колонка" нет.

    # --- Фокус монитора (niri focus-monitor-*) ---
    "SUPER+SHIFT,Left,focusmon,left"
    "SUPER+SHIFT,Right,focusmon,right"
    "SUPER+SHIFT,Up,focusmon,up"
    "SUPER+SHIFT,Down,focusmon,down"
    "SUPER+SHIFT,H,focusmon,left"
    "SUPER+SHIFT,J,focusmon,down"
    "SUPER+SHIFT,K,focusmon,up"
    "SUPER+SHIFT,L,focusmon,right"

    # --- Перенос окна на монитор в направлении (niri move-column-to-monitor-*) ---
    # tagmon: направление,[keeptag] — keeptag=1, чтобы сохранить номер тега,
    # это ближе всего к поведению niri.
    "SUPER+SHIFT+CTRL,Left,tagmon,left,1"
    "SUPER+SHIFT+CTRL,Right,tagmon,right,1"
    "SUPER+SHIFT+CTRL,Up,tagmon,up,1"
    "SUPER+SHIFT+CTRL,Down,tagmon,down,1"
    "SUPER+SHIFT+CTRL,H,tagmon,left,1"
    "SUPER+SHIFT+CTRL,J,tagmon,down,1"
    "SUPER+SHIFT+CTRL,K,tagmon,up,1"
    "SUPER+SHIFT+CTRL,L,tagmon,right,1"

    # --- Переключение "workspace" ---
    # ВАЖНО: у mango нет per-monitor стека workspace'ов как в niri — есть 9
    # общих тегов. focus-workspace-down/up -> ближайший смысл это
    # "следующий/предыдущий тег".
    "SUPER,Page_Down,viewtoright"
    "SUPER,Page_Up,viewtoleft"
    "SUPER,U,viewtoright"
    "SUPER,I,viewtoleft"

    "SUPER+CTRL,Page_Down,tagtoright"   # niri: move-column-to-workspace-down
    "SUPER+CTRL,Page_Up,tagtoleft"      # niri: move-column-to-workspace-up
    "SUPER+CTRL,U,tagtoright"
    "SUPER+CTRL,I,tagtoleft"

    # move-workspace-down/up (переставить сам workspace в стеке монитора) —
    # НЕТ АНАЛОГА, у mango нет понятия "стек workspace'ов".

    # --- Колесо мыши (niri WheelScrollDown/Up) -> axisbind, см. отдельный список ниже ---

    # --- Числовые теги (1-в-1 с niri workspaces 1-9) ---
    "SUPER,1,view,1"
    "SUPER,2,view,2"
    "SUPER,3,view,3"
    "SUPER,4,view,4"
    "SUPER,5,view,5"
    "SUPER,6,view,6"
    "SUPER,7,view,7"
    "SUPER,8,view,8"
    "SUPER,9,view,9"

    "SUPER+SHIFT,1,tag,1"
    "SUPER+SHIFT,2,tag,2"
    "SUPER+SHIFT,3,tag,3"
    "SUPER+SHIFT,4,tag,4"
    "SUPER+SHIFT,5,tag,5"
    "SUPER+SHIFT,6,tag,6"
    "SUPER+SHIFT,7,tag,7"
    "SUPER+SHIFT,8,tag,8"
    "SUPER+SHIFT,9,tag,9"

    # consume-or-expel-window-left/right -> scroller_stack (раскладка scroller).
    # Направления сопоставлены по смыслу, но советую перепроверить руками —
    # это самое "приблизительное" место во всём переносе.
    "SUPER,bracketleft,scroller_stack,left"
    "SUPER,bracketright,scroller_stack,right"

    # consume-window-into-column / expel-window-from-column — та же механика,
    # что и bracketleft/right выше в scroller-раскладке mango, отдельных
    # диспетчеров под "consume именно в column" / "expel именно из column" нет.
    "SUPER,comma,scroller_stack,left"
    "SUPER,period,scroller_stack,right"

    # switch-preset-window-height / reset-window-height — НЕТ АНАЛОГА
    # (в mango нет отдельного измерения "высота окна" вне master/stack factor).

    "SUPER+SHIFT,F,togglefullscreen"

    # expand-column-to-available-width — ближайшее в scroller: full width
    "SUPER+CTRL,F,set_proportion,1.0"

    # set-column-width ±10% — в mango нет относительного "+/-10%" для scroller,
    # только abсолютный set_proportion и циклический switch_proportion_preset.
    # Используем пресеты вместо continuous-резайза:
    "SUPER,minus,switch_proportion_preset"
    "SUPER,equal,switch_proportion_preset"

    # set-window-height ±10% — НЕТ АНАЛОГА, ближайшее по духу это setmfact
    # для master-stack раскладок:
    "SUPER+SHIFT,minus,setmfact,-0.05"
    "SUPER+SHIFT,equal,setmfact,+0.05"

    # switch-focus-between-floating-and-tiling — НЕТ АНАЛОГА.

    # screenshot-screen (write-to-disk=true) — mango не умеет скриншотить
    # сам, нужны grim+slurp. Не забудь добавить их в home.packages.
    "SUPER+SHIFT,S,spawn,grim -g \"$(slurp)\" $HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"

    # toggle-keyboard-shortcuts-inhibit — НЕТ прямого диспетчера в mango.

    "SUPER+SHIFT,E,quit"      # niri: quit
    "CTRL+ALT,Delete,quit"    # niri: Ctrl+Alt+Delete quit

    # power-off-monitors — нет одной команды "выключить все", используем
    # wlr-dpms (нужно установить пакет wlr-dpms):
    "SUPER+SHIFT,P,spawn,wlr-dpms off"
  ];

  # Прокрутка колёсиком мыши (niri Mod+WheelScrollDown/Up и т.п.)
  wayland.windowManager.mango.settings.axisbind = [
    "SUPER,DOWN,viewtoright"
    "SUPER,UP,viewtoleft"
    "SUPER+CTRL,DOWN,tagtoright"
    "SUPER+CTRL,UP,tagtoleft"
    "SUPER,RIGHT,focusdir,right"
    "SUPER,LEFT,focusdir,left"
    "SUPER+CTRL,RIGHT,exchange_client,right"
    "SUPER+CTRL,LEFT,exchange_client,left"
    "SUPER+SHIFT,DOWN,focusdir,right"
    "SUPER+SHIFT,UP,focusdir,left"
    "SUPER+SHIFT+CTRL,DOWN,exchange_client,right"
    "SUPER+SHIFT+CTRL,UP,exchange_client,left"
  ];
}
