_: {
  flake.nixosModules.niri-config =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    (lib.mkIf config.rawkOS.desktop.niri.enable {
      # Don't set programs.niri.enable here as it's handled by the niri flake input
      # Just provide additional configuration
      programs.niri.enable = true;
      systemd.user.services.niri-flake-polkit.enable = false;

      environment.systemPackages = with pkgs; [
        # Clipboard management
        wl-clipboard

        # Screen management
        hyprlock
        hypridle
        brightnessctl

        # Notification daemon
        swaynotificationcenter

        # Wallpaper
        swww

        # Authentication agent
        polkit_gnome

        # Network management
        iwgtk

        # Audio management
        pavucontrol
        pasystray

        # Other utilities
        blueman
      ];
    });
}
