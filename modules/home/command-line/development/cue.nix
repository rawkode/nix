_: {
  flake.homeModules.command-line-cue =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        cue
      ];
    };
}
