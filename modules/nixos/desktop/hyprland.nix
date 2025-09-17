{
  flake.nixosModules.hyprland =
    { pkgs, ... }:
    {
      programs.hyprland.enable = true;

      environment.systemPackages = with pkgs; [
        blueman
        brightnessctl
        hypridle
        hyprlock
        hyprpolkitagent
        iwgtk
        pavucontrol
        swaynotificationcenter
        swww
        wl-clipboard
      ];
    };
}
