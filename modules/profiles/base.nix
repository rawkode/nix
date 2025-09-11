# Base profile relocated from nixos/profiles
_: {
  flake.nixosModules.profiles-base =
    {
      inputs,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.self.nixosModules.common or { }
        inputs.self.nixosModules.nix or { }
        inputs.self.nixosModules.networking or { }
        inputs.self.nixosModules.user or { }
        inputs.self.nixosModules.sudo or { }
        inputs.self.nixosModules.systemd or { }
        inputs.self.nixosModules.containers or { }
        inputs.self.nixosModules.tailscale or { }
        inputs.self.nixosModules.below or { }
        inputs.self.nixosModules.lanzaboote or { }
        inputs.self.nixosModules.tpm2 or { }
        inputs.self.nixosModules.desktop-greetd or { }
        inputs.self.nixosModules.dns or { }
        inputs.disko.nixosModules.disko
        inputs.flatpaks.nixosModules.nix-flatpak
        inputs.niri.nixosModules.niri
        inputs.nur.modules.nixos.default
        inputs.self.nixosModules.stylix
        inputs.nix-index-database.nixosModules.nix-index
      ];

      environment.systemPackages = with pkgs; [
        vim
        git
        htop
        curl
        wget
      ];

      boot.loader.efi = {
        canTouchEfiVariables = lib.mkDefault true;
        efiSysMountPoint = lib.mkDefault "/boot";
      };

      nixpkgs.config = {
        allowUnfree = true;
        joypixels.acceptLicense = true;
      };

      nix = {
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          auto-optimise-store = true;
        };
        gc = {
          automatic = lib.mkDefault true;
          dates = "weekly";
          options = "--delete-older-than 30d";
        };
        registry = {
          nixpkgs.flake = inputs.nixpkgs;
          rawkode.flake = inputs.self;
          templates.flake = inputs.self;
        };
      };

      system.stateVersion = "25.11";
    };
}
