{ inputs, ... }:
{
  flake.nixosModules.niri-config =
    { pkgs, ... }:
    {
      # Don't set programs.niri.enable here as it's handled by the niri flake input
      # Just provide additional configuration
      programs.niri.enable = true;

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

        # App launcher
        fuzzel
        bemoji

        # Authentication agent
        # polkit_gnome

        # Screenshot utilities
        grim
        slurp

        # Other utilities
        blueman
        pavucontrol
      ];
    };
}
