{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  hardware.graphics = { # Замена hardware OpenGL с 25.05+
    enable = true;
    enable32Bit = true; # 32-битные библиотеки
    extraPackages = with pkgs; [
      nvidia-vaapi-driver # VA-API поверх NVDEC, нужен для аппаратного декодирования видео
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true; # обязателен для Wayland

    open = false; # Че поделать, тут я гнида :D (Ampere серия вроде поддерживает открытые дрова, но пока нестабильно)

    package = config.boot.kernelPackages.nvidiaPackages.production;

    nvidiaSettings = true; # ставит nvidia-settings GUI

    powerManagement.enable = false; # десктоп без батареи
  };

  # Переменные окружения для корректной работы Wayland-композиторов и Electron-приложений с NVIDIA
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct"; # для nvidia-vaapi-driver
    # GBM_BACKEND = "nvidia-drm"; # раскомментируй, если будут проблемы с screen-share/курсором в Wayland-приложениях
  };

  # Kernel-параметр, который часто требуется для стабильного suspend/resume и раннего KMS на NVIDIA
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  # Аппаратное ускорение видео в Chromium/Electron-приложениях через Wayland (Ozone)
  environment.variables.NIXOS_OZONE_WL = "1";
}
