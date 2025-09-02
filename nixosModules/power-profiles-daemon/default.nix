{ lib, pkgs, ... }:
{
  services.power-profiles-daemon = {
    enable = true;
  };

  # Ensure thermald doesn't conflict with power-profiles-daemon
  services.thermald.enable = lib.mkDefault false;
}