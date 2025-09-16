{
  flake.nixosModules.networking = {
    networking = {
      networkmanager.enable = false;

      wireless.iwd = {
        enable = true;
        settings = {
          IPv4 = {
            dhcp = "yes";
          };
          Settings = {
            AutoConnect = true;
          };
        };
      };

      nameservers = [
        "9.9.9.9"
        "149.112.112.112"
      ];
    };
  };
}
