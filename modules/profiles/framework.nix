# Framework profile relocated
_:
{
  flake.nixosModules.profiles-framework =
    {
      inputs,
      ...
    }:
    {
      imports = [
        ./laptop.nix
        ./development.nix
        inputs.self.nixosModules.hardware-amd
        inputs.self.nixosModules.kernel
        inputs.nixos-hardware.nixosModules.framework-13-7040-amd
      ];

      boot.kernelParams = [ "amdgpu.sg_display=0" ];
      services.fprintd.enable = true;
      boot.kernelModules = [
        "cros_ec"
        "cros_ec_lpcs"
        "mt7921e"
      ];
      services.xserver.dpi = 200;
      environment.variables = {
        GDK_SCALE = "2";
        GDK_DPI_SCALE = "0.5";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      };
    };
}
