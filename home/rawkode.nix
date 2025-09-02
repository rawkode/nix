# This returns homeManagerConfiguration args for flakelight
{ inputs, ... }:
{
  system = "x86_64-linux";
  modules = [
    ({ pkgs, ... }: {
      imports = [
        # Import flake modules
        inputs.flatpaks.homeManagerModules.nix-flatpak
        inputs.nix-index-database.homeModules.nix-index
        inputs.nur.modules.homeManager.default
        inputs.stylix.homeManagerModules.stylix
        
        # Import rawkOS home modules
        ../homeModules/rawkOS.nix
      ];

      # Basic home configuration
      home.username = "rawkode";
      home.homeDirectory = "/home/rawkode";
      home.stateVersion = "25.05";

      # TODO: Migrate snowfallorg user settings
      # snowfallorg.user.enable = true;

      # Programs managed by home-manager
      programs.home-manager.enable = true;
    })
  ];
}