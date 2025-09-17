{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      programs.wayfire = {
        enable = true;
        plugins = with pkgs.wayfirePlugins; [
          wcm
          wf-shell
          wayfire-plugins-extra
        ];
      };
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
