{ pkgs, ... }:

let theme = (import ./themes/brewer.nix).theme;
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
    pasystray
    pavucontrol
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

    polybar = {
      enable = true;

      package = pkgs.polybar.override {
        i3GapsSupport = true;
        alsaSupport = true;
      };

      script = "polybar top &";

      config = {
        colors = {
          background = "\${xrdb:background}";
          foreground = "\${xrdb:foreground}";

          primary = "\${xrdb:color4}";
          secondary = "\${xrdb:color2}";
          alert = "\${xrdb:color1}";

          black = "\${xrdb:color0}";
          blackLight = "\${xrdb:color8}";

          red = "\${xrdb:color1}";
          redLight = "\${xrdb:color9}";

          green = "\${xrdb:color2}";
          greenLight = "\${xrdb:color10}";

          yellow = "\${xrdb:color3}";
          yellowLight = "\${xrdb:color11}";

          purple = "\${xrdb:color4}";
          purpleLight = "\${xrdb:color12}";

          pink = "\${xrdb:color5}";
          pinkLight = "\${xrdb:color13}";

          blue = "\${xrdb:color6}";
          blueLight = "\${xrdb:color14}";

          grey = "\${xrdb:color7}";
          greyLight = "\${xrdb:color15}";
        };

        "bar/top" = {
          width = "100%";
          height = "32";

          radius = 0;

          fixed-center = true;
          underline-size = 4;
          underline-color = "\${colors.primary}";

          spacing = 2;
          module-margin = 2;
          module-padding = 2;
          border-top-size = 2;
          border-bottom-size = 0;
          border-right-size = 0;
          border-left-size = 0;

          background = "\${colors.background}";
          foreground = "\${colors.foreground}";

          font-0 = "roboto:pixelsize=11";
          font-1 = "Noto Color Emoji:scale=11";
          font-2 = "Font Awesome 5 Free:style=Solid:size=10;1";
          font-3 = "Font Awesome 5 Brands:size=10;1";

          modules-left = "i3 xwindow";
          modules-center = "date";
          modules-right = "battery volume wlan";

          tray-position = "right";
          tray-padding = 16;
          tray-offset-x = 16;

          tray-transparent = false;
          tray-background = "\${colors.background}";

          cursor-click = "pointer";
          cursor-scroll = "ns-resize";
        };

        "module/xwindow" = {
          type = "internal/xwindow";

          label = " 💻  %title:0:120:...% ";
          label-padding = 2;

          format-background = "\${colors.background}";
          format-foreground = "\${colors.blueLight}";
        };

        "module/i3" = {
          type = "internal/i3";

          index-sort = true;
          wrapping-scroll = false;
          pin-workspaces = false;

          format = "<label-state> <label-mode>";

          label-mode-padding = 2;
          label-mode-foreground = "\${colors.foreground}";
          label-mode-background = "\${colors.background}";

          label-focused = "%index%";
          label-focused-background = "\${colors.background}";
          label-focused-underline = "\${colors.primary}";
          label-focused-padding = 2;

          label-unfocused = "%index%";
          label-unfocused-background = "\${colors.background}";
          label-unfocused-underline = "\${colors.background}";
          label-unfocused-padding = 2;

          label-visible = "%index%";
          label-visible-background = "\${colors.background}";
          label-visible-underline = "\${colors.secondary}";
          label-visible-padding = 2;

          label-urgent = "%index%";
          label-urgent-background = "\${colors.alert}";
          label-urgent-underline = "\${colors.alert}";
          label-urgent-padding = 2;
        };

        "module/date" = {
          type = "internal/date";

          interval = 1.0;

          format-background = "\${colors.yellowLight}";
          format-foreground = "\${colors.blackLight}";

          label = " %time% ";

          time = "  %H:%M ";
          time-alt = "  %A, %e %B ";
        };


        "module/battery" = {
          type = "internal/battery";

          full-at = 99;

          battery = "BAT0";
          adapter = "AC0";

          poll-interval = 5;

          label-charging = "%percentage%";
          format-charging = "<animation-charging>  <label-charging>";
          format-charging-background = "\${colors.pinkLight}";
          format-charging-padding = 4;

          label-discharging = "%percentage%";
          format-discharging = "<ramp-capacity>  <label-discharging>";
          format-discharging-background = "\${colors.pinkLight}";
          format-discharging-padding = 4;

          label-full = "%percentage%";
          format-full = "<ramp-capacity>  <label-full>";
          format-full-background = "\${colors.pinkLight}";
          format-full-padding = 4;

          ramp-capacity-0 = "";
          ramp-capacity-1 = "";
          ramp-capacity-2 = "";
          ramp-capacity-3 = "";
          ramp-capacity-4 = "";

          animation-charging-0 = "";
          animation-charging-1 = "";
          animation-charging-2 = "";
          animation-charging-3 = "";
          animation-charging-4 = "";
          animation-charging-framerate = 750;
        };

        "module/backlight" = {
          type = "internal/backlight";

          card = "intel_backlight";
          enable-scroll = true;

          format = "<ramp> <label>";
          label = "%percentage%";

          ramp-0 = "🌕";
          ramp-1 = "🌔";
          ramp-2 = "🌓";
          ramp-3 = "🌒";
          ramp-4 = "🌑";
        };

        "module/volume" = {
          type = "internal/alsa";

          label-volume = "%percentage%";

          format-volume = "<ramp-volume> <label-volume>";
          format-volume-foreground = "\${colors.blackLight}";
          format-volume-background = "\${colors.blueLight}";
          format-volume-padding = 2;

          label-muted = " muted";
          label-muted-foreground = "\${colors.greyLight}";

          format-muted = "<label-muted>";
          format-muted-background = "\${colors.redLight}";
          format-muted-padding = 2;

          ramp-volume-0 = "";
          ramp-volume-1 = "";
          ramp-volume-2 = "";
          ramp-headphones-0 = "";
        };

        "module/wlan" = {
          type = "internal/network";

          interface = "wlp2s0";

          interval = 5;

          label-connected = " %essid%";
          label-connected-background = "\${colors.greenLight}";
          label-connected-foreground = "\${colors.blackLight}";
          label-connected-padding = 2;

          label-disconnected = " Not Connected";
          label-disconnected-background = "\${colors.redLight}";
          label-disconnected-foreground = "\${colors.blackLight}";
          label-disconnected-padding = 2;
        };

        settings = {
          screenchange-reload = true;
        };

        "global/wm" = {
          margin-top = 5;
          margin-bottom = 5;
        };
      };
    };
  };
}
