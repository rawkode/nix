_: {
  flake.homeModules.command-line-just =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        just
      ];
    };
}
