{ inputs, ... }:
{
  flake.nixosModules.niri-portal =
    { lib, pkgs, ... }:
    {
      # This module just imports the shared portals configuration
      imports = [ inputs.self.nixosModules.portals ];
    };
}
