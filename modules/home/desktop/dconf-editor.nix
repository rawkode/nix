_:
{
  flake.homeModules.desktop-dconf-editor =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.dconf-editor ];
    };
}
