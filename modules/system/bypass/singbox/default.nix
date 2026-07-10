{ pkgs, config, ... }:
let
  cfg = import ./settings.nix;
in
{
  sops.secrets."singbox/uuid" = {
    sopsFile = ./secrets.yaml;
    key = "uuid";
  };
  sops.secrets."singbox/pbk" = {
    sopsFile = ./secrets.yaml;
    key = "pbk";
  };
  sops.secrets."singbox/sid" = {
    sopsFile = ./secrets.yaml;
    key = "sid";
  };
  services.sing-box = {
      enable = true;
      package = pkgs.sing-box;
      settings = {
        log = {
          level = "info";
          timestamp = true;
        };
        dns = {
          strategy = "ipv4_only";
          servers = [
            {
              type = "https";
              tag = "dns-secure";
              server = "8.8.8.8";
              tls = {
                server_name = "dns.google";
              };
              detour = "proxy";
            }
            {
              type = "https";
              tag = "dns-direct";
              server = "77.88.8.88";
              tls = {
                server_name = "safe.dot.dns.yandex.net";
              };
            }
          ];
          rules = [
            {
              rule_set = [ "sites-direct" ];
              server = "dns-direct";
            }
          ];
          final = "dns-secure";
        };
        inbounds = [
          {
            type = "mixed";
            tag = "socks-in";
            listen = "127.0.0.1";
            listen_port = 1080;
          }
        ];
        outbounds = [
          {
            type = "vless";
            tag = "proxy";
            server = cfg.server;
            server_port = cfg.port;
            uuid._secret = config.sops.secrets."singbox/uuid".path;
            transport = {
              type = "grpc";
              service_name = cfg.serviceName;
              # Если нужен multi‑mode, можно добавить:
              # mode = "multi";
            };
            tls = {
              enabled = true;
              server_name = cfg.sni;
              reality = {
                enabled = true;
                public_key._secret = config.sops.secrets."singbox/pbk".path;
                short_id._secret = config.sops.secrets."singbox/sid".path;
              };
              utls = {
                enabled = true;
                fingerprint = cfg.fingerprint;
              };
            };
          }
          {
            type = "direct";
            tag = "direct";
          }
        ];
        route = {
          default_domain_resolver = {
            server = "dns-secure";
          };
          rules = [
            {
              action = "sniff";
              sniffer = [ "tls" "http" "quic" "dns" ];
              timeout = "300ms";
            }
            {
              protocol = "dns";
              action = "hijack-dns";
            }
            {
              action = "resolve";
            }
            {
              ip_is_private = true;
              action = "route";
              outbound = "direct";
            }
            {
              rule_set = [ "sites-direct" ];
              action = "route";
              outbound = "direct";
            }
          ];
          final = "proxy";
          rule_set = [
            {
              tag = "sites-direct";
              rules = [
                { domain_suffix = [
                    ".ru"
                    ".su"
                    ".xn--p1ai"
                    "yandex.net"
                    "yastatic.net"
                    "vk.com"
                    "vk-portal.net"
                    "2gis.com"
                  ];
                }
              ];
            }
          ];
        };
        experimental = {
          cache_file.enabled = true;
        };
      };
    };
}
