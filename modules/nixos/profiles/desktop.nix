# Desktop profile - Dendritic pattern flake-parts module
{ inputs, ... }:
{
  flake.nixosModules.profiles-desktop =
    { lib, pkgs, ... }:
    {
      imports = [
        inputs.self.nixosModules.onepassword
        inputs.self.nixosModules.audio
        inputs.self.nixosModules.bluetooth
        inputs.self.nixosModules.chrome
        inputs.self.nixosModules.desktop-common
        inputs.self.nixosModules.desktop-firefox
        inputs.self.nixosModules.flatpak
        inputs.self.nixosModules.fonts
        inputs.self.nixosModules.location
        inputs.self.nixosModules.niri-config
        inputs.self.nixosModules.niri-portal
        inputs.self.nixosModules.plymouth
        # inputs.self.nixosModules.stylix-config
        inputs.self.nixosModules.profiles-base
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
      nix.settings.substituters = lib.mkAfter (inputs.firefox.nixConfig.substituters or [ ]);
      nix.settings.trusted-public-keys = lib.mkAfter (
        inputs.firefox.nixConfig.trusted-public-keys or [ ]
      );
    };
}
