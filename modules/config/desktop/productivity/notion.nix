{
  flake.darwinModules.notion =
    { lib, ... }:
    {
      homebrew = {
        enable = lib.mkDefault true;
        casks = [ "notion" ];
      };
    };
}
