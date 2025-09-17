{ inputs, ... }:
{
  flake.homeModules.hyprland =
    {
      lib,
      pkgs,
      ...
    }:
    {
      imports = with inputs; [
        self.homeModules.darkman
        self.homeModules.hypridle
        self.homeModules.swaync
        self.homeModules.swww
      ];

      # programs.quickshell-bar.enable = true;

      home.packages = with pkgs; [
        cosmic-files
        cosmic-panel
        kitty # Recommended by Hyprland wiki
      ];

      xdg.portal = {
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
        ];
        config = {
          hyprland = {
            default = [
              "hyprland"
              "gtk"
            ];
            "org.freedesktop.impl.portal.FileChooser" = [
              "gtk"
            ];
            "org.freedesktop.impl.portal.Notification" = [
              "gtk"
            ];
            "org.freedesktop.impl.portal.Screenshot" = [
              "hyprland"
            ];
            "org.freedesktop.impl.portal.ScreenCast" = [
              "hyprland"
            ];
            "org.freedesktop.impl.portal.Secret" = [
              "gnome-keyring"
            ];
          };
        };
      };

      services.swayosd.enable = true;

      systemd.user.services = {
        # Override swayosd to only run in Hyprland
        swayosd = {
          Unit = {
            ConditionEnvironment = lib.mkForce [
              "WAYLAND_DISPLAY" # Keep the original condition
              "XDG_CURRENT_DESKTOP=Hyprland"
            ];
          };
        };

      };

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = true;
        xwayland.enable = true;

        settings = {
          "$mod" = "SUPER";
          "$terminal" = "ghostty";
          "$fileManager" = "cosmic-files";
          "$menu" = "vicinae";

          env = [
            "XDG_CURRENT_DESKTOP,Hyprland"
            "XDG_SESSION_TYPE,wayland"
            "XDG_SESSION_DESKTOP,Hyprland"
            "QT_QPA_PLATFORM,wayland"
            "GSK_RENDERER,vulkan" # Force Vulkan for maximum GTK performance
          ];

          exec-once = [
            # Start hyprpolkitagent
            "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"
            # Ensure portals are started early
            "systemctl --user start xdg-desktop-portal.service xdg-desktop-portal-hyprland.service xdg-desktop-portal-gtk.service"
            # Start tray applications
            "blueman-applet"
            "iwgtk-indicator"
          ];

          monitor = [
            # Laptop
            "eDP-1,preferred,0x0,2"

            # Office Monitors
            "DP-1,preferred,0x540,2"
            "DP-2,preferred,1920x540,2"

            # Teleprompter monitor
            "Invalid Vendor Codename - RTK Field Monitor J257M96B00FL,1920x1080@60,0x0,2,transform,2"

            # Home monitor
            "Samsung Electric Company LS32A70 HK2WB00305,preferred,auto,1.75"
          ];

          input = {
            kb_layout = "us";
            kb_options = "";
            numlock_by_default = true;
            follow_mouse = 1;
            mouse_refocus = false;

            touchpad = {
              natural_scroll = true;
              tap-to-click = true;
              clickfinger_behavior = true;
              disable_while_typing = true;
              middle_button_emulation = true;
            };

            sensitivity = 0;
          };

          general = {
            gaps_in = 8;
            gaps_out = 16;
            border_size = 2;
            # Stylix handles border colors automatically

            layout = "dwindle";
            allow_tearing = false;
          };

          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

            animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };

          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };

          master = {
            new_status = "master";
          };

          misc = {
            force_default_wallpaper = 0;
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            mouse_move_enables_dpms = true;
            key_press_enables_dpms = true;
          };

          windowrulev2 = [
            # Browsers
            "workspace name:Web, class:^(vivaldi|vivaldi-stable|firefox)$"

            # Firefox PiP
            "float, class:^firefox$, title:^Picture-in-Picture$"
            "pin, class:^firefox$, title:^Picture-in-Picture$"

            # Chat apps
            "workspace name:Chat, class:^(Slack|org.zulip.Zulip)$"

            # Zoom
            "float, class:^(zoom)$"
            "center, class:^(zoom)$"
            "nofocus, class:^(zoom)$, title:^(Zoom)$"

            # Development
            "workspace name:Code, class:^(code|Code|com.mitchellh.ghostty)$"

            # Floating windows
            "rounding 16, floating:1"

            # Privacy
            "noblur, class:^(1Password)$"
            "noblur, title:.*[Gg]mail.*"
            "opacity 0.0 override 0.0 override, class:^(.*swaync.*)$"
          ];

          workspace = [
            "1, defaultName:Web,  persistent:true, monitor:DP-1"
            "2, defaultName:Code, persistent:true, monitor:DP-2"
            "3, defaultName:Chat, persistent:true, monitor:DP-1"
          ];

          bind = [
            # Window management
            "$mod, Q, killactive"
            "$mod SHIFT, Q, exit"
            "$mod, F, fullscreen"
            "$mod, V, togglefloating"
            "$mod, P, pseudo"
            "$mod, J, togglesplit"
            "$mod, T, togglegroup"

            # Applications
            "$mod, Return, exec, $terminal"
            "$mod, Space, exec, $menu"
            "$mod SHIFT, Space, exec, vicinae vicinae://extensions/vicinae/wm/switch-windows"
            "$mod, E, exec, vicinae vicinae://extensions/vicinae/vicinae/search-emojis"
            "$mod, C, exec, vicinae vicinae://extensions/vicinae/clipboard/history"
            "$mod, N, exec, swaync-client -t"
            "$mod, Backslash, exec, 1password --quick-access"

            # Lock & power
            "$mod, L, exec, hyprlock"
            "$mod SHIFT, L, exec, hyprctl dispatch dpms off"

            # Move focus
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"

            # Move windows
            "$mod SHIFT, left, movewindow, l"
            "$mod SHIFT, right, movewindow, r"
            "$mod SHIFT, up, movewindow, u"
            "$mod SHIFT, down, movewindow, d"

            # Switch workspaces
            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod, 5, workspace, 5"
            "$mod, 6, workspace, 6"
            "$mod, 7, workspace, 7"
            "$mod, 8, workspace, 8"
            "$mod, 9, workspace, 9"
            "$mod, 0, workspace, 10"

            # Move to workspace
            "$mod SHIFT, 1, movetoworkspace, 1"
            "$mod SHIFT, 2, movetoworkspace, 2"
            "$mod SHIFT, 3, movetoworkspace, 3"
            "$mod SHIFT, 4, movetoworkspace, 4"
            "$mod SHIFT, 5, movetoworkspace, 5"
            "$mod SHIFT, 6, movetoworkspace, 6"
            "$mod SHIFT, 7, movetoworkspace, 7"
            "$mod SHIFT, 8, movetoworkspace, 8"
            "$mod SHIFT, 9, movetoworkspace, 9"
            "$mod SHIFT, 0, movetoworkspace, 10"

            # Special workspace
            "$mod, S, togglespecialworkspace, magic"
            "$mod SHIFT, S, movetoworkspace, special:magic"

            # Scroll through workspaces
            "$mod, mouse_down, workspace, e+1"
            "$mod, mouse_up, workspace, e-1"

            # Monitor focus
            "$mod, Page_Down, focusmonitor, +1"
            "$mod, Page_Up, focusmonitor, -1"
            "$mod SHIFT, Page_Down, movewindow, mon:+1"
            "$mod SHIFT, Page_Up, movewindow, mon:-1"

            # Screenshots
            ", Print, exec, hyprshot -m window"
            "$mod, Print, exec, hyprshot -m output"
            "$mod SHIFT, Print, exec, hyprshot -m region"

            # Media keys
            ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
            ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ];

          bindm = [
            # Move/resize with mouse
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];
        };
      };

    };
}
