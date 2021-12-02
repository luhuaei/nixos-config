{ config, lib, pkgs, ... }:

{

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  programs.nm-applet.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  # Configure network proxy if necessary
  networking.proxy.default = "http://127.0.0.1:1080";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
    after = [ "network.target" ];
    description = "V2Ray Service";
    serviceConfig = {
      User = "nobody";
      CapabilityBoundingSe = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      NoNewPrivileges = true;
      ExecStart = ''${pkgs.v2ray}/bin/v2ray -c /etc/v2ray/config.json'';
      Restart = "on-failure";
      RestartPreventExitStatus = 23;
    };
  };
}
