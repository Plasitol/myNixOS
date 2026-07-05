{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    enableGlobalCompInit = false;
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users.plasitol = {
      isNormalUser = true;
      description = "plasitol";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "kvm"
        "libvirtd"
        "plugdev"
      ];
      ignoreShellProgramCheck = true;
    };
  };
}
