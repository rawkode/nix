# Desktop profile relocated and updated with GNOME/Niri toggles
{ inputs, ... }:
{
  flake.nixosModules.profiles-desktop =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      options.rawkOS.desktop = {
        niri.enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable the Niri Wayland compositor and related supporting packages.";
        };
        gnome.enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable the GNOME desktop environment (GDM + GNOME Shell).";
        };
      };

      imports = [
        inputs.self.nixosModules.onepassword
        inputs.self.nixosModules.audio
        inputs.self.nixosModules.bluetooth
        inputs.self.nixosModules.chrome
        inputs.self.nixosModules.desktop-common
        inputs.self.nixosModules.desktop-firefox
        inputs.self.nixosModules.desktop-vivaldi
        inputs.self.nixosModules.flatpak
        inputs.self.nixosModules.fonts
        inputs.self.nixosModules.location
        inputs.self.nixosModules.plymouth
        inputs.self.nixosModules.profiles-base
        inputs.self.nixosModules.niri-config
        inputs.self.nixosModules.niri-portal
        inputs.self.nixosModules.desktop-gnome
      ];

      config = {
        services = {
          xserver.enable = true;
          pipewire = {
            enable = true;
            alsa.enable = true;
            pulse.enable = true;
          };
          printing.enable = true;
        };

        nix.settings.substituters = lib.mkAfter (inputs.firefox.nixConfig.substituters or [ ]);
        nix.settings.trusted-public-keys = lib.mkAfter (
          inputs.firefox.nixConfig.trusted-public-keys or [ ]
        );
      };
    };
}
