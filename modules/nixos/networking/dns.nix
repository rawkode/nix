{
  flake.nixosModules.dns = {
    # Primary DNS servers - Quad9 for privacy and security
    networking.nameservers = [
      "9.9.9.9"
      "149.112.112.112"
    ];

    services.resolved = {
      enable = true;
      dnssec = "false"; # Disabled due to iwd/resolved crashes
      domains = [ "~." ];
      # Fallback DNS servers - Cloudflare as secondary
      fallbackDns = [
        "1.1.1.1"
        "2606:4700:4700::1111"
        "1.0.0.1"
        "2606:4700:4700::1001"
      ];
      dnsovertls = "opportunistic";
      extraConfig = ''
        MulticastDNS=no
        DNSStubListenerExtra=127.0.0.54
        Cache=yes
        CacheFromLocalhost=yes
      '';
    };

    networking.networkmanager.dns = "systemd-resolved";

    # Disable resolvconf to prevent conflicts
    networking.resolvconf.enable = false;
  };
}
