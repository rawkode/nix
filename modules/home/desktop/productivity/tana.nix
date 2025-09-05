_: {
  flake.homeModules.desktop-tana =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ tana ];
    };
}
