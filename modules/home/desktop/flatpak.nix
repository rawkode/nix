{
  flake.homeModules.flatpak = {
    services.flatpak = {
      enable = true;

      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];

      packages = [
        "org.pipewire.Helvum"
      ];
    };
  };
}
