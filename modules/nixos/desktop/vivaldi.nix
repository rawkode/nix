{
  flake.nixosModules.desktop-vivaldi =
    { pkgs, ... }:
    let
      vivaldi-wayland = pkgs.vivaldi.override {
        commandLineArgs = [
          "--enable-features=UseOzonePlatform" # Better Wayland support
          "--ozone-platform=wayland" # Native Wayland support
          "--enable-features=VaapiVideoDecoder" # Hardware video acceleration
          "--disable-features=UseChromeOSDirectVideoDecoder" # Prevents conflicts with VAAPI
        ];
      };
    in
    {
      environment.systemPackages = [
        vivaldi-wayland
      ];
    };
}
