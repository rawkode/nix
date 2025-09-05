_: {
  flake.nixosModules.networking-tailscale =
    {
      config,
      lib,
      ...
    }:
    let
      port = 41641;
    in
    {
      networking.firewall.interfaces.${config.services.tailscale.interfaceName}.allowedTCPPorts = [ 22 ];
      networking.firewall.checkReversePath = "loose";

      services.tailscale = {
        enable = true;
        inherit port;
        openFirewall = true;
        extraUpFlags = lib.mkDefault [ "--ssh" ];
      };
    };
}
