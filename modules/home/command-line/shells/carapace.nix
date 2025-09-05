{ inputs, ... }:
{
  flake.homeModules.command-line-carapace =
    { ... }:
    {
      programs.carapace = {
        enable = true;

        enableFishIntegration = true;
        enableNushellIntegration = true;
      };
    };
}
