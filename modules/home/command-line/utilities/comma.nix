_: {
  flake.homeModules.command-line-comma =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ comma ];
    };
}
