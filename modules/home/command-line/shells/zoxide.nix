{ inputs, ... }:
{
  flake.homeModules.command-line-zoxide = {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
