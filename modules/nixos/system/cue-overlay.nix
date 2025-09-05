# CUE overlay to provide updated CUE package
{ inputs, ... }:
{
  flake.nixosModules.cue-overlay =
    { ... }:
    {
      nixpkgs.overlays = [
        (final: prev: {
          cue = inputs.cue.legacyPackages.${prev.system}.cue;
        })
      ];
    };
}