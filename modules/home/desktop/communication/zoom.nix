_:
{
  flake.homeModules.desktop-zoom =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.zoom-us ];
    };
}
