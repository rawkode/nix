{
  flake.nixosModules.vivaldi =
    { pkgs, ... }:
    let
      vivaldi-wayland = pkgs.vivaldi.override {
        commandLineArgs = [
          # Better Wayland support
          "--enable-features=UseOzonePlatform"
          # Native Wayland support
          "--ozone-platform=wayland"
          # Hardware video acceleration
          "--enable-features=VaapiVideoDecoder"
          # Prevents conflicts with VAAPI
          "--disable-features=UseChromeOSDirectVideoDecoder"
        ];
      };
    in
    {
      environment.systemPackages = [
        vivaldi-wayland
      ];
    };
}
