{ config, ... }:
{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets = {
      "ssh_id_mlsrv" = {
        path = "${config.home.homeDirectory}/.ssh/id_mlsrv.pub";
        mode = "0600";
      };
      "ssh_id_github" = {
        path = "${config.home.homeDirectory}/.ssh/id_github.pub";
        mode = "0600";
      };
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;  # больше не полагаемся на скрытые дефолты

    settings = {
      "mlSrv" = {
        hostname = "109.195.87.247";
        user = "deploy";
        port = 22;
        identityFile = config.sops.secrets."ssh_id_mlsrv".path;
        identitiesOnly = true;
      };
      "github.com" = {
        user = "git";
        identityFile = config.sops.secrets."ssh_id_github".path;
        identitiesOnly = true;
      };
      "*" = {
        addKeysToAgent = "yes";
        forwardX11 = false;
        hashKnownHosts = true;
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
      };
    };
  };
}
