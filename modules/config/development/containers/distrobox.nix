_: {
  flake.homeModules.development-distrobox =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        boxbuddy
        distrobox
        toolbox
      ];
    };
}
