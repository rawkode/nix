# This returns homeManagerConfiguration args for flakelight
# Note: flakelight passes inputs to the home-manager configuration via extraSpecialArgs
_: {
  system = "x86_64-linux";
  modules = [
    ({ pkgs, lib, inputs, ... }: {
      imports = [
        # Import flake modules - inputs come from extraSpecialArgs
        inputs.flatpaks.homeManagerModules.nix-flatpak
        inputs.nix-index-database.homeModules.nix-index
        inputs.niri.homeModules.niri
        inputs.niri.homeModules.stylix
        inputs.nur.modules.homeManager.default
        inputs.stylix.homeModules.stylix

        # Import rawkode home modules from auto-discovered modules
        inputs.self.homeModules.ai
        inputs.self.homeModules.command-line
        inputs.self.homeModules.desktop
        inputs.self.homeModules.development
        inputs.self.homeModules.nix
        inputs.self.homeModules.stylix
      ];

      # Basic home configuration
      home.username = "rawkode";
      home.homeDirectory = "/home/rawkode";
      home.stateVersion = "25.05";

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowUnfreePredicate = _: true;

      # TODO: Migrate snowfallorg user settings
      # snowfallorg.user.enable = true;

      # Programs managed by home-manager
      programs.home-manager.enable = true;
    })
  ];
}
