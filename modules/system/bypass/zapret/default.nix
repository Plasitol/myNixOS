{ inputs, ... }:

let
  cfg = import ./settings.nix;
in
{
  services.zapret-discord-youtube = {
    enable = true;

    configName = cfg.configName;
    listGeneral = cfg.listGeneral;
    listExclude = cfg.listExclude;
    ipsetAll = cfg.ipsetAll;
    ipsetExclude = cfg.ipsetExclude;
  };
}
