_: {
  flake.homeModules.command-line-jq =
    # jq - Command-line JSON processor
    {
      pkgs,
      ...
    }:

    {
      home.packages = with pkgs; [
        jq
      ];
    };
}
