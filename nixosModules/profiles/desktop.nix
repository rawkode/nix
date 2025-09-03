# Desktop profile - for systems with GUI
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./base.nix
    ../audio
    ../bluetooth
    ../fonts
    ../desktop/common
    ../desktop/firefox
    ../flatpak
    ../1password
    ../chrome
    ../niri
    ../plymouth
    ../stylix
    ../location       # Geolocation services for desktop apps
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
    vlc
    libreoffice
  ];

  # Adopt caches recommended by the firefox-nightly flake if provided via its nixConfig
  # This will append to any host-specific caches defined elsewhere.
  nix.settings.substituters = lib.mkAfter (inputs.firefox.nixConfig.substituters or []);
  nix.settings.trusted-public-keys = lib.mkAfter (inputs.firefox.nixConfig.trusted-public-keys or []);
}
