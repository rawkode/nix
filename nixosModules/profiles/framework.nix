# Framework laptop specific profile
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./laptop.nix
    ./development.nix
    ../hardware/amd.nix  # Framework 13 AMD
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  # Framework-specific settings
  boot.kernelParams = [
    "amdgpu.sg_display=0"  # Fix for display issues
  ];

  # Fingerprint reader support
  services.fprintd.enable = true;

  # Framework keyboard backlight control
  boot.kernelModules = [ "cros_ec" "cros_ec_lpcs" ];

  # High DPI display
  services.xserver.dpi = 200;
  
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}