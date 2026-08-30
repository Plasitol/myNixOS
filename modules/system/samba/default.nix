{ ... }:

{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        "hosts allow" = "192.168.1.1/24 127.0.0.1";
        "hosts deny" = "0.0.0.0/0";
      };

      public = {
        path = "/srv/samba/public";
        browseable = "yes";
        "guest ok" = "yes";
        "read only" = "yes";
      };

      private = {
        path = "/home/plasitol/shared";
        "valid users" = "plasitol";
        "force user" = "plasitol";
        "public" = "no";
        "writeable" = "yes";
      };
    };
  };
}
