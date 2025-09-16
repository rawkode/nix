{ inputs, ... }:
let
  machines = builtins.attrNames (builtins.readDir ../../machines);
  homeModule =
    { ... }:
    {
      home.username = "rawkode";
      home.homeDirectory = "/home/rawkode";
      home.stateVersion = "25.11";

      programs.home-manager.enable = true;

      nixpkgs.config.allowUnfree = true;

      imports = with inputs; [
        flatpaks.homeManagerModules.nix-flatpak
        ironbar.homeManagerModules.default
        niri.homeModules.niri
        nix-index-database.homeModules.nix-index
        nur.modules.homeManager.default
        vicinae.homeManagerModules.default

        self.homeModules.ai
        self.homeModules.command-line
        self.homeModules.desktop
        self.homeModules.development
        self.homeModules.nix
        self.homeModules.portals
        self.homeModules.stylix
        self.homeModules.vicinae
      ];
    };

  flake.homeModules.users-rawkode = homeModule;

  flake.homeConfigurations = builtins.listToAttrs (
    map (machine: {
      name = "rawkode@${machine}";
      value = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        modules = [ homeModule ];
        extraSpecialArgs = { inherit inputs; };
      };
    }) machines
  );

  flake.nixosModules.users-rawkode.imports = [
    home
    linux
    user
  ];

  home.home-manager.users.rawkode.imports = [
    homeModule
  ];

  linux = {
    users.users.rawkode = {
      isNormalUser = true;
      extraGroups = [
        "audio"
        "docker"
        "input"
        "libvirtd"
        "networkmanager"
        "video"
        "wheel"
      ];
    };
  };

  user =
    { pkgs, ... }:
    {
      home-manager.backupFileExtension = "backup";

      users.users.rawkode = {
        description = "David Flanagan";
        shell = pkgs.fish;
      };
    };
in
{
  inherit flake;
}
