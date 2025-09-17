{
  flake.homeModules.hypridle =
    { pkgs, lib, ... }:
    {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            # Avoid starting multiple instances of hyprlock.
            # Avoid starting multiple instances of hyprlock
            lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
            before_sleep_cmd = "loginctl lock-session; sleep 1;";
            after_sleep_cmd = ''sleep 0.5; niri msg action power-on-monitors'';
          };

          listener = [
            # Monitor power save
            {
              timeout = 720; # 12 min
              on-timeout = "niri msg action power-off-monitors";
              on-resume = "niri msg action power-on-monitors";
            }

            # Dim screen
            {
              timeout = 300; # 5 min
              on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
              on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
            }

            # Dim keyboard
            {
              timeout = 300; # 5 min
              on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -sd rgb:kbd_backlight set 0";
              on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -rd rgb:kbd_backlight";
            }

            {
              timeout = 600; # 10 min
              on-timeout = "loginctl lock-session";
            }
          ];
        };
      };

      # Make hypridle work with Niri
      systemd.user.services.hypridle = {
        Unit = {
          ConditionEnvironment = lib.mkForce [
            "WAYLAND_DISPLAY"
          ];
          # Start with Niri
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
