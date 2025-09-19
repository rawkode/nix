{
  flake.homeModules.vicinae = _: {
    services.vicinae = {
      enable = true;
      settings = {
        faviconService = "google";
        font = {
          normal = "Monaspace Argon";
          size = 12;
        };
        popToRootOnClose = true;
        rootSearch = {
          searchFiles = false;
        };
        theme = {
          name = "rosepine-dawn";
        };
        window = {
          csd = true;
          opacity = 0.95;
          rounding = 16;
        };
      };
    };
  };
}
