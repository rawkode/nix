{ inputs, ... }:
{
  flake.nixosModules.profiles-base =
    # Base profile - included in all systems
    {
      inputs,
      config,
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

        # Essential services for all hosts
        inputs.self.nixosModules.containers or { } # Docker & Podman
        inputs.self.nixosModules.tailscale or { } # VPN networking
        inputs.self.nixosModules.below or { } # System monitoring
        inputs.self.nixosModules.lanzaboote or { } # Secure Boot management
        inputs.self.nixosModules.tpm2 or { } # TPM support

        # Desktop services
        inputs.self.nixosModules.desktop-greetd or { } # Modern login manager with ReGreet

        # Security and networking
        inputs.self.nixosModules.u2f or { } # U2F/YubiKey authentication
        inputs.self.nixosModules.dns or { } # DNS configuration with DNSSEC

        # Common flake modules used across all systems
        inputs.disko.nixosModules.disko # Disk configuration
        inputs.flatpaks.nixosModules.nix-flatpak
        inputs.niri.nixosModules.niri
        inputs.nur.modules.nixos.default
        inputs.stylix.nixosModules.stylix
        inputs.nix-index-database.nixosModules.nix-index
      ];

      # Essential packages for all systems
      environment.systemPackages = with pkgs; [
        vim
        git
        htop
        curl
        wget
      ];

      # Common boot configuration
      boot.loader.efi = {
        canTouchEfiVariables = lib.mkDefault true;
        efiSysMountPoint = lib.mkDefault "/boot";
      };

      # Allow unfree packages (required for Zoom, Spotify, etc.)
      nixpkgs.config = {
        allowUnfree = true;
        joypixels.acceptLicense = true;
      };

      # Basic nix settings
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

        # Common registry settings for all systems
        registry = {
          nixpkgs.flake = inputs.nixpkgs;
          rawkode.flake = inputs.self;
          templates.flake = inputs.self;
        };
      };

      system.stateVersion = "25.11";
    };
}
