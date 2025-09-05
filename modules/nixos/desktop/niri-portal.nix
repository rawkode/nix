{ inputs, ... }:
{
  flake.nixosModules.niri-portal =
    { ... }:
    {
      # This module just imports the shared portals configuration
      imports = [ inputs.self.nixosModules.portals ];
    };
}
