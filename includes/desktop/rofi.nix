{ ... }:

let
  theme = (import ./themes/brewer.nix).theme;
in {
  programs.rofi = {
    enable = true;

    lines = 10;
    location = "center";
    width = 60;

    padding = 5;
    borderWidth = 2;

    colors = {
      window = {
        background = theme.background;
        border = theme.color6;
        separator = theme.color4;
      };

      rows = {
        normal = {
          background = theme.background;
          foreground = theme.foreground;

          backgroundAlt = theme.background;

          highlight = {
            background = theme.color6;
            foreground = theme.color15;
          };
        };

        urgent = {
          background = theme.color1;
          foreground = theme.color1;

          backgroundAlt = theme.color2;

          highlight = {
            background = theme.color1;
            foreground = theme.color1;
          };
        };

        active = {
          background = theme.color6;
          foreground = theme.color15;

          backgroundAlt = theme.color1;

          highlight = {
            background = theme.color6;
            foreground = theme.color3;
          };
        };
      };
    };

    separator = "solid";
  };
}
