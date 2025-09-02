{ ... }:
{
  # Flatpak configuration for home-manager
  services.flatpak = {
    enable = true;
    
    # Add Flathub repository
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    
    # Install Flatpak applications
    packages = [
      # Add specific Flatpak apps here if needed
      # "com.spotify.Client"
      # "com.slack.Slack"
    ];
  };
}