{ inputs, ... }:
{
  flake.homeModules.command-line-btop =
    { ... }:
    {
      programs.btop = {
        enable = true;
      };
    };
}
