{ pkgs, ... }:

let theme = (import ./themes/base16.nix).theme;
in {
  imports = [
    ./i3.nix
    ./rofi.nix
  ];

  home.packages = (with pkgs; [
    arc-icon-theme
    arc-theme
    bibata-cursors
    gnome3.nautilus
    materia-theme
  ]);

  gtk = {
    enable = true;

    font = {
      name = "Bitter 11";
      package = pkgs.google-fonts;
    };

    theme = {
      name = "Arc-Darker";
    };

    iconTheme = {
      name = "Arc";
    };
  };

  xresources.properties = {
    "Xft.antialias" = 1;
    "Xft.autohint" = 0;
    "Xft.hinting" = 1;
    "Xft.hintstyle" = "hintfull";
    "Xft.lcdfilter" = "lcddefault";

    "Xcursor.theme" = "Bibata Oil";

    "*.foreground"  = theme.foreground;
    "*.background"  = theme.background;
    "*.cursorColor" = theme.cursorColor;
    "*.color0"      = theme.color0;
    "*.color8"      = theme.color8;
    "*.color1"      = theme.color1;
    "*.color9"      = theme.color9;
    "*.color2"      = theme.color2;
    "*.color10"     = theme.color10;
    "*.color3"      = theme.color3;
    "*.color11"     = theme.color11;
    "*.color4"      = theme.color4;
    "*.color12"     = theme.color12;
    "*.color5"      = theme.color5;
    "*.color13"     = theme.color13;
    "*.color6"      = theme.color6;
    "*.color14"     = theme.color14;
    "*.color7"      = theme.color7;
    "*.color15"     = theme.color15;
  };

  services = {
    compton = {
      enable = true;
      blur = true;
      shadow = true;
    };

    dunst = {
      enable = true;

      settings = {
        frame = {
          width = 2;
          color = theme.color4;
        };

        global = {
          geometry = "300x5+50-20";

          transparency = 20;

          padding = 8;
          horizontal_padding = 8;

          line_height = 0;

          separator_color = "frame";

          markup = "full";
          alignment = "left";
          word_wrap = "true";
        };

        shortcuts = {
          close = "ctrl+Escape";
          close_all = "ctrl+shift+Escape";
        };

        urgency_low = {
          timeout = 4;

          foreground = theme.foreground;
          background = theme.color0;
        };

        urgency_normal = {
          timeout = 8;

          foreground = theme.foreground;
          background = theme.color0;
        };

        urgency_critical = {
          timeout = 0;

          foreground = theme.color15;
          background = theme.color1;
        };
      };
    };
  };
}
