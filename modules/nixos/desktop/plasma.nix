{
  flake.nixosModules.kde =
    { lib, pkgs, ... }:
    {
      services = {
        desktopManager.plasma6.enable = true;
        displayManager.sddm.enable = lib.mkForce false;
      };

      environment.plasma6.excludePackages = with pkgs; [
        kdePackages.elisa
        kdePackages.kmahjongg
        kdePackages.kmines
        kdePackages.konversation
        kdePackages.kpat
        kdePackages.ksudoku
        kdePackages.ktorrent
        mpv
      ];

      environment.systemPackages = with pkgs; [
        kdePackages.discover
        kdePackages.kcalc
        kdePackages.kclock
        kdePackages.kcolorchooser
        kdePackages.kolourpaint
        kdePackages.ksystemlog
        kdiff3
        kdePackages.isoimagewriter
        wayland-utils
        wl-clipboard
      ];
    };
}
