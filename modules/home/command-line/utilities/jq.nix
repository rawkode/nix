{ inputs, ... }:
{
  flake.homeModules.command-line-jq =
    # jq - Command-line JSON processor
    {
      config,
      lib,
      pkgs,
      ...
    }:

    {
      home.packages = with pkgs; [
        jq
      ];
    };
}
