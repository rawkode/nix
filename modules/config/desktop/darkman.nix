{
  flake.homeModules.darkman =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        glib
        gsettings-desktop-schemas
      ];

      services.darkman = {
        enable = true;

        settings.usegeoclue = true;

        darkModeScripts = {
          gtk = ''
            export XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:''${XDG_DATA_DIRS:-/run/current-system/sw/share}"
            ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme prefer-dark
          '';
        };

        lightModeScripts = {
          gtk = ''
            export XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:''${XDG_DATA_DIRS:-/run/current-system/sw/share}"
            ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme prefer-light
          '';
        };
      };
    };
}
