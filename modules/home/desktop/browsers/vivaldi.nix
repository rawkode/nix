{ inputs, ... }:
{
  flake.homeModules.desktop-vivaldi =
    { ... }:
    {
      # Vivaldi is available but not set as default browser
      # Firefox module handles default application associations
    };
}
