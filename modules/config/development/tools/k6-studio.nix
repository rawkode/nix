{
  flake.darwinModules.k6-studio =
    { lib, ... }:
    {
      homebrew = {
        enable = lib.mkDefault true;
        casks = [ "k6-studio" ];
      };
    };
}
