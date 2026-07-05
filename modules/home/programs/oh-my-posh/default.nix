{ config, pkgs, ... }:
let
  c = config.lib.stylix.colors;

  # Читаем твой исходный json-конфиг
  rawJsonConfig = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./config.json));
in
{
  # 1. КРИТИЧНО: Отключаем авто-тему Stylix, чтобы он не сломал наш кастомный лейаут
  #stylix.targets.oh-my-posh.enable = false;

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    # 2. Берем твой конфиг и подменяем в нем секцию palette на цвета из Stylix
    settings = rawJsonConfig // {
       palette = {
        os       = "#${c.base08}"; # красный — под status/error
        pink     = "#${c.base09}"; # под root-маркер
        lavender = "#${c.base0A}"; # под git
        blue     = "#${c.base0D}"; # главный синий
        white    = "#${c.base07}"; # светлый текст (поправил опечатку "wight")
        text     = "#${c.base05}"; # обычный текст
      };
    };
  };
}
