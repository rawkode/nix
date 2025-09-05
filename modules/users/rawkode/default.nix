{ inputs, ... }:
let
  # Dynamically get machines from the filesystem
  machines = builtins.attrNames (builtins.readDir ../../machines);

  # Home module configuration
  flake.homeModules.users-rawkode =
    { ... }:
    {
      home.username = "rawkode";
      home.homeDirectory = "/home/rawkode";
      home.stateVersion = "25.11";

      programs.home-manager.enable = true;

      # Allow all unfree packages
      nixpkgs.config.allowUnfree = true;

      imports = [
        inputs.flatpaks.homeManagerModules.nix-flatpak
        inputs.niri.homeModules.niri
        inputs.nix-index-database.homeModules.nix-index
        inputs.nur.modules.homeManager.default
        inputs.stylix.homeModules.stylix

        inputs.self.homeModules.ai
        inputs.self.homeModules.command-line
        inputs.self.homeModules.desktop
        inputs.self.homeModules.development
        inputs.self.homeModules.nix
        inputs.self.homeModules.stylix
      ];
    };

  # Standalone home configurations - generated from machines list
  flake.homeConfigurations = builtins.listToAttrs (
    map (machine: {
      name = "rawkode@${machine}";
      value = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        modules = [ inputs.self.homeModules.users-rawkode ];
        extraSpecialArgs = { inherit inputs; };
      };
    }) machines
  );

  # NixOS module imports
  flake.nixosModules.users-rawkode.imports = [
    user
    linux
    home
  ];

  # Home-manager integration for NixOS
  home.home-manager.users.rawkode.imports = [
    inputs.self.homeModules.users-rawkode
  ];

  # Linux user configuration
  linux = {
    users.users.rawkode = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "audio"
        "input"
        "docker"
        "libvirtd"
      ];
    };
  };

  # Common user configuration
  user =
    { pkgs, ... }:
    {
      home-manager.backupFileExtension = "backup";

      programs.fish.enable = true;

      users.users.rawkode = {
        description = "David Flanagan";
        shell = pkgs.fish;
      };
    };
in
{
  inherit flake;
}
