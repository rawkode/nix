{
  flake.homeModules.darkman = {
    services.darkman = {
      enable = true;

      settings.usegeoclue = true;

      darkModeScripts = {
        gtk = ''
          gsettings set org.gnome.desktop.interface color-scheme prefer-dark
        '';
      };

      lightModeScripts = {
        gtk = ''
          gsettings set org.gnome.desktop.interface color-scheme prefer-light
        '';
      };
    };
  };
}
