{ inputs, ... }:
{
  flake.nixosModules.profiles-framework =
    # Framework laptop specific profile
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:
    {
      imports = [
        ./laptop.nix
        ./development.nix
        inputs.self.nixosModules.hardware-amd # Framework 13 AMD
        inputs.self.nixosModules.kernel # Ensure consistent kernel version (linux_zen)
        inputs.nixos-hardware.nixosModules.framework-13-7040-amd
      ];

      # Framework-specific settings
      boot.kernelParams = [
        "amdgpu.sg_display=0" # Fix for display issues
      ];

      # Fingerprint reader support
      services.fprintd.enable = true;

      # Framework keyboard backlight control and WiFi support
      boot.kernelModules = [
        "cros_ec"
        "cros_ec_lpcs"
        "mt7921e"
      ];

      # High DPI display
      services.xserver.dpi = 200;

      environment.variables = {
        GDK_SCALE = "2";
        GDK_DPI_SCALE = "0.5";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      };
    };
}
