{
  flake.homeModules.desktop-vicinae =
    { pkgs, ... }:
    {
      services.vicinae = {
        enable = true;
        settings = {
          faviconService = "google";
          font = {
            size = 10;
          };
          popToRootOnClose = false;
          rootSearch = {
            searchFiles = true;
          };
          theme = {
            name = "vicinae-dark";
          };
          window = {
            csd = true;
            opacity = 0.95;
            rounding = 10;
          };
        };
      };
    };
}
