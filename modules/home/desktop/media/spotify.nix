{ inputs, ... }:
{
  flake.homeModules.desktop-spotify =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        spotify
      ];
    };
}
