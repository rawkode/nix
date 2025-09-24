{ inputs, ... }:
{
  flake.nixosModules.profiles-desktop =
    { ... }:
    {
      imports = with inputs; [
        self.nixosModules.profiles-base

        self.nixosModules.vivaldi
        self.nixosModules.audio
        self.nixosModules.bluetooth
        self.nixosModules.chrome
        self.nixosModules.common
        self.nixosModules.firefox
        self.nixosModules.flatpak
        self.nixosModules.fonts
        self.nixosModules.location
        self.nixosModules.niri
        self.nixosModules.onepassword
        self.nixosModules.plymouth
        self.nixosModules.polkit
        self.nixosModules.portals
      ];

      config = {
        services = {
          pipewire = {
            enable = true;
            alsa.enable = true;
            pulse.enable = true;
          };
          printing.enable = true;
        };
      };
    };
}
