# CUE overlay to provide updated CUE package
{ inputs, ... }:
{
  flake.nixosModules.cue-overlay =
    _:
    {
      nixpkgs.overlays = [
        (_final: prev: {
          inherit (inputs.cue.legacyPackages.${prev.system}) cue;
        })
      ];
    };
}
