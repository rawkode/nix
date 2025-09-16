{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      programs.niri.enable = true;
      systemd.user.services.niri-flake-polkit.enable = false;

      environment.systemPackages = with pkgs; [
        blueman
        brightnessctl
        hypridle
        hyprlock
        iwgtk
        pavucontrol
        polkit_gnome
        swaynotificationcenter
        swww
        wl-clipboard
      ];
    };
}
