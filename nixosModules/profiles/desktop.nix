# Desktop profile - for systems with GUI
{ config, lib, pkgs, ... }:
{
  imports = [
    ./base.nix
    ../audio
    ../bluetooth
    ../fonts
    ../desktop/common
    ../flatpak
    ../1password
    ../chrome
    ../niri
    ../plymouth
  ];

  # Desktop services
  services = {
    xserver.enable = true;
    
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    
    printing.enable = true;
  };

  # Desktop packages
  environment.systemPackages = with pkgs; [
    firefox
    vlc
    libreoffice
  ];
}