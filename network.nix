{ config, lib, pkgs, ... }:

{

  networking.hostName = "nixos"; # Define your hostname.
  networking.dhcpcd.enable = false;
  networking.networkmanager = {
    enable = true;
    logLevel = "TRACE";
    dns = "none";
    insertNameservers = [ "127.0.0.1" "::1" ];
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  services.coredns.enable = true;
  services.coredns.config =
    ''
      . {
        # Cloudflare and Google
        forward . 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4
        cache
      }

      local {
        template IN A  {
            answer "{{ .Name }} 0 IN A 127.0.0.1"
        }
      }
    '';

  # Configure network proxy if necessary
  networking.proxy.default = "http://127.0.0.1:1080";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain,heiyu.space";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 8080 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  environment.systemPackages = with pkgs; [
    wget
    curl
    v2ray
  ];

  systemd.services.v2ray = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" "nss-lookup.target" ];
    description = "V2Ray Service";
    serviceConfig = {
      User = "nobody";
      Environment = "V2RAY_LOCATION_ASSET=/etc/v2ray";
      CapabilityBoundingSe = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      ExecStart = ''${pkgs.v2ray}/bin/v2ray -c /etc/v2ray/config.json'';
    };
  };
}
