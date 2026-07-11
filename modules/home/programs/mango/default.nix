{ pkgs, inputs, ... }:
{
  imports = [
    ./binds.nix
    ./settings.nix
    ./rules.nix
  ];

  wayland.windowManager.mango = {
    enable = true;

    # Дефолтный пакет модуля — mango-nightly (собирается из main).
    # Если хочешь именно тот пакет, что даёт сам флейк mango:
    # package = inputs.mango.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
