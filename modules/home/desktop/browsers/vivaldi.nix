_: {
  flake.homeModules.vivaldi = {
    xdg.mimeApps =
      let
        defaultApplications = {
          "default-web-browser" = [ "vivaldi.desktop" ];
          "text/html" = [ "vivaldi.desktop" ];
          "x-scheme-handler/http" = [ "vivaldi.desktop" ];
          "x-scheme-handler/https" = [ "vivaldi.desktop" ];
          "x-scheme-handler/about" = [ "vivaldi.desktop" ];
          "x-scheme-handler/unknown" = [ "vivaldi.desktop" ];
          "application/xhtml+xml" = [ "vivaldi.desktop" ];
          "text/xml" = [ "vivaldi.desktop" ];
        };
      in
      {
        enable = true;
        inherit defaultApplications;
        associations.added = defaultApplications;
      };

    # Set the BROWSER environment variable to ensure Vivaldi is used
    home.sessionVariables = {
      BROWSER = "vivaldi";
      DEFAULT_BROWSER = "vivaldi.desktop";
    };
  };
}
