{ inputs, ... }:
{
  flake.homeModules.command-line-jj =
    { ... }:
    {
      programs.jujutsu = {
        enable = true;
      };
    };
}
