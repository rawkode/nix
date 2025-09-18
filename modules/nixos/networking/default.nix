{
  flake.nixosModules.networking = {
    networking = {
      networkmanager.enable = true;

      nameservers = [
        "9.9.9.9"
        "149.112.112.112"
      ];
    };
  };
}
