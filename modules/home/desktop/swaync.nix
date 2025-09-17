{
  flake.homeModules.swaync =
    { pkgs, ... }:
    {
      systemd.user.services.swaync = {
        Unit = {
          Description = "SwayNotificationCenter";
          Documentation = "https://github.com/ErikReider/SwayNotificationCenter";
          # Start with either Niri or Hyprland
          ConditionEnvironment = "WAYLAND_DISPLAY";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session-pre.target" ];
          Requisite = [ "graphical-session.target" ];
        };

        Service = {
          Type = "simple";
          ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
          Restart = "on-failure";
          RestartSec = "1s";
        };

        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };

      xdg.configFile."swaync/config.json".text = ''
        {
          "positionX": "right",
          "positionY": "top",
          "layer": "overlay",
          "control-center-margin-top": 0,
          "control-center-margin-bottom": 0,
          "control-center-margin-right": 0,
          "control-center-margin-left": 0,
          "notification-2fa-action": true,
          "notification-inline-replies": false,
          "notification-icon-size": 64,
          "notification-body-image-height": 100,
          "notification-body-image-width": 200,
          "timeout": 10,
          "timeout-low": 5,
          "timeout-critical": 0,
          "fit-to-screen": true,
          "control-center-width": 500,
          "control-center-height": 600,
          "notification-window-width": 500,
          "keyboard-shortcuts": true,
          "image-visibility": "when-available",
          "transition-time": 200,
          "hide-on-clear": false,
          "hide-on-action": true,
          "script-fail-notify": true,
          "notification-visibility": {
            "example-name": {
              "state": "muted",
              "urgency": "Low",
              "app-name": "Spotify"
            }
          },
          "widgets": [
            "title",
            "buttons-grid",
            "mpris",
            "volume",
            "backlight",
            "dnd",
            "notifications"
          ],
          "widget-config": {
            "title": {
              "text": "Notification Center",
              "clear-all-button": true,
              "button-text": "Clear All"
            },
            "dnd": {
              "text": "Do Not Disturb"
            },
            "label": {
              "max-lines": 5,
              "text": "Label Text"
            },
            "mpris": {
              "image-size": 96,
              "image-radius": 12
            },
            "volume": {
              "expand-button-label": "⏷",
              "collapse-button-label": "⏶",
              "show-per-app": true
            },
            "backlight": {
              "device": "intel_backlight",
              "subsystem": "backlight"
            },
            "buttons-grid": {
              "actions": [
                {
                  "label": "⚡",
                  "command": "systemctl poweroff"
                },
                {
                  "label": "🔃",
                  "command": "systemctl reboot"
                },
                {
                  "label": "🔒",
                  "command": "if [ \"$XDG_CURRENT_DESKTOP\" = \"niri\" ]; then swaylock; elif [ \"$XDG_CURRENT_DESKTOP\" = \"Hyprland\" ]; then hyprlock; fi"
                },
                {
                  "label": "🚪",
                  "command": "if [ \"$XDG_CURRENT_DESKTOP\" = \"niri\" ]; then niri msg logout; elif [ \"$XDG_CURRENT_DESKTOP\" = \"Hyprland\" ]; then hyprctl dispatch exit; fi"
                },
                {
                  "label": "⏸️",
                  "command": "systemctl suspend"
                }
              ]
            }
          }
        }
      '';
    };
}
