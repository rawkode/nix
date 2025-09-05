_: {
  flake.homeModules.command-line-lazyjournal =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        lazyjournal
      ];
    };
}
