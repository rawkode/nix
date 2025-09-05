{ inputs, ... }:
{
  flake.homeModules.desktop-clickup =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        clickup
      ];
    };
}
