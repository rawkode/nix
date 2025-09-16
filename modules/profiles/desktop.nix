{ inputs, ... }:
{
  flake.nixosModules.profiles-desktop =
    { ... }:
    {
      imports = with inputs; [
        self.nixosModules.audio
        self.nixosModules.bluetooth
        self.nixosModules.chrome
        self.nixosModules.common
        self.nixosModules.vivaldi
        self.nixosModules.flatpak
        self.nixosModules.fonts
        self.nixosModules.gnome
        self.nixosModules.location
        self.nixosModules.niri
        self.nixosModules.onepassword
        self.nixosModules.plymouth
        self.nixosModules.polkit
        self.nixosModules.portals
        self.nixosModules.profiles-base
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
      };
    };
}
