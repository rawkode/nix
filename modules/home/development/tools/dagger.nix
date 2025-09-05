{ inputs, ... }:
{
  flake.homeModules.development-dagger =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      home.packages = (with pkgs; [ inputs.dagger.packages.${system}.dagger ]);
    };
}
