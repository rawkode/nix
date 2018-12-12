{ lib, ... }:

let
  modifier = "Mod4";
  theme = (import ./themes/base16.nix).theme;
in {
  xsession = {
    enable = true;

    windowManager.i3 = {
      enable = true;

      config = {
        modifier = modifier;

        bars = [];

        focus = {
          followMouse = false;
          newWindow = "smart";
        };

        colors = {
          background = theme.background;
          focused = {
            border = "$color12";
            background = "$color4";
            text = "$color8";
            indicator = "$color4";
            childBorder = "$color12";
          };

          unfocused = {
            border = "$color0";
            background = "$background";
            text = "$foreground";
            indicator = "$color2";
            childBorder = "$color0";
          };

          focusedInactive = {
            border = "$color0";
            background = "$background";
            text = "$foreground";
            indicator = "$color2";
            childBorder = "$color0";
          };

          placeholder = {
            border = "$color0";
            background = "$background";
            text = "$foreground";
            indicator = "$color2";
            childBorder = "$color0";
          };

          urgent = {
            border = "$color0";
            background = "$background";
            text = "$foreground";
            indicator = "$color1";
            childBorder = "$color0";
          };
        };

        gaps = {
          inner = 8;
          outer = 8;

          smartBorders = "on";
        };

        keybindings =
          lib.mkOptionDefault {
            "${modifier}+Shift+e" = "i3-msg exit";
            "${modifier}+Pause" = "i3-msg exit";
            "${modifier}+l" = "i3-lock --color ${theme.color6}";
            "Pause" = "i3-lock --color ${theme.color6}";

            "${modifier}+1" = "workspace 1";
            "${modifier}+2" = "workspace 2";
            "${modifier}+3" = "workspace 3";
            "${modifier}+4" = "workspace 4";
            "${modifier}+5" = "workspace 5";
            "${modifier}+6" = "workspace 6";
            "${modifier}+7" = "workspace 7";
            "${modifier}+8" = "workspace 8";
            "${modifier}+9" = "workspace 9";
            "${modifier}+0" = "workspace 10";

            "${modifier}+Shift+1" = "move container to workspace 1";
            "${modifier}+Shift+2" = "move container to workspace 2";
            "${modifier}+Shift+3" = "move container to workspace 3";
            "${modifier}+Shift+4" = "move container to workspace 4";
            "${modifier}+Shift+5" = "move container to workspace 5";
            "${modifier}+Shift+6" = "move container to workspace 6";
            "${modifier}+Shift+7" = "move container to workspace 7";
            "${modifier}+Shift+8" = "move container to workspace 8";
            "${modifier}+Shift+9" = "move container to workspace 9";
            "${modifier}+Shift+0" = "move container to workspace 10";

            "${modifier}+Up" = "focus up";
            "${modifier}+Right" = "focus right";
            "${modifier}+Left" = "focus left";
            "${modifier}+Down" = "focus down";

            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Right" = "move down";
            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Down" = "move down";

            "${modifier}+h" = "split h";
            "${modifier}+v" = "split v";

            "${modifier}+f" = "fullscreen";

            "${modifier}+s" = "layout stacking";
            "${modifier}+w" = "layout tabbed";
            "${modifier}+e" = "layout toggle split";

            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+a" = "focus parent";

            "${modifier}+minus" = "scratchpad show";
            "${modifier}+Shift+minus" = "move scratchpad";

            "${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+r" = "restart";
            "${modifier}+p" = "polymar-msg cmd restart";

            "${modifier}+q" = "kill";
            "${modifier}+r" = "resize";

            "XF86AudioRaiseVolume" = "exec pactl set-sink-mute @DEFAULT_SINK@ false && pactl set-sink-volume @DEFAULT_SINK@ +5% && V=`pamixer --get-volume` && notify-send \"Raising Volume to \${V}%\"";

            "XF86AudioLowerVolume" = "exec pactl set-sink-mute @DEFAULT_SINK@ false && pactl set-sink-volume @DEFAULT_SINK@ -5% && V=`pamixer --get-volume` && notify-send \"Lowering Volume to \${V}%\"";

            "${modifier}+Return" = "alacritty";

            "${modifier}+space" = "rofi -show drun";
            "${modifier}+Home" = "rofi -show drun";

            "${modifier}+End" = "rofi -show window";
            "Control+Down" = "rofi -show window";

            "Print" = "flameshot gui";
          };
        modes = {
          resize = {
            Left = "resize shrink width 10 px or 10 ppt";
            Down = "resize grow height 10 px or 10 ppt";
            Up = "resize shrink height 10 px or 10 ppt";
            Right = "resize grow width 10 px or 10 ppt";
            Return = "mode \"default\"";
            Escape = "mode \"default\"";
          };
        };

        startup = [
          {
            command = "compton --config $HOME/.config/compton.conf -b";
            notification = false;
          }
          {
            command = "nitrogen --restore";
            notification = false;
          }
          {
            command = "polybar top";
            notification = false;
          }
          {
            command = "dunst";
            notification = false;
          }
          {
            command = "nm-applet";
            notification = false;
          }
          {
            command = "notify-send -a i3 \"loaded\" \"👋 Welcome 👋\"";
            notification = true;
          }
        ];
        window.commands = [];
      };

      extraConfig = ''
        # Colors set from ~/.Xresources
        set_from_resource	$background	background
        set_from_resource	$foreground	foreground
        set_from_resource	$color0		color0
        set_from_resource $color1 	color1
        set_from_resource $color2 	color2
        set_from_resource $color3 	color3
        set_from_resource $color4 	color4
        set_from_resource $color5 	color5
        set_from_resource $color6		color6
        set_from_resource	$color7		color7
        set_from_resource	$color8		color8
        set_from_resource	$color9		color9
        set_from_resource	$color10	color10
        set_from_resource	$color11	color11
        set_from_resource	$color12	color12
        set_from_resource	$color13	color13
        set_from_resource	$color14	color14
        set_from_resource	$color15	color15
      '';
    };
  };
}
