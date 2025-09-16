{
  flake.homeModules.wezterm =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        wezterm
      ];

      xdg.configFile."wezterm" = {
        source = ./wezterm/config;
        recursive = true;
      };
    };
}
