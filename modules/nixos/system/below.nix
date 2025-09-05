{ inputs, ... }:
{
  flake.nixosModules.below =
    { ... }:
    {
      services.below.enable = true;
    };
}
