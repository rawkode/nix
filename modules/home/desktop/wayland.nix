_: {
  flake.homeModules.desktop-wayland =
    {
      pkgs,
      ...
    }:
    {
      home.sessionVariables = {
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };

      home.packages = with pkgs; [
        wl-clipboard
      ];
    };
}
