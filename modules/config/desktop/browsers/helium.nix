{
  flake.darwinModules.helium =
    { lib, ... }:
    {
      homebrew = {
        enable = lib.mkDefault true;
        casks = [ "helium-browser" ];
      };
    };
}
