{ pkgs, lib, ... }:
{
  services.thermald.enable = true;

  systemd.services.thermald.serviceConfig.ExecStart = lib.mkForce ''
    ${pkgs.thermald}/sbin/thermald --no-daemon --dbus-enable --ignore-cpuid-check
  '';

  boot.kernelModules = [ "intel_rapl_msr" "thinkpad_acpi" ];

  boot.kernelParams = [
    "i915.enable_psr=1"
    "i915.enable_fbc=1"
    "rtc_cmos.use_acpi_alarm=0"
  ];

  boot.kernel.sysctl."kernel.nmi_watchdog" = 0;

  boot.kernel.sysctl."vm.dirty_writeback_centisecs" = 1500;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil"; #powersave когда жестко / schedutil можно поработать
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power"; #power когда жестко / balance_power можно поработать

      WIFI_PWR_ON_AC = "on";
      WIFI_PWR_ON_BAT = "on";

      SOUND_POWER_SAVE_ON_AC = 1;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";

      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;

      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";
    };
  };

  services.power-profiles-daemon.enable = false;
  services.fwupd.enable = true;
}
