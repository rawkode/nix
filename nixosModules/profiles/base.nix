# Base profile - included in all systems
{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ../common
    ../nix
    ../networking
    ../user
    ../sudo
    ../systemd

    # Essential services for all hosts
    ../containers # Docker & Podman
    ../tailscale # VPN networking
    ../below # System monitoring
    ../kernel/secureboot # Secure Boot management
    ../tpm2 # TPM support

    # Desktop services
    ../desktop/greetd # Modern login manager with ReGreet

    # Security and networking
    ../u2f # U2F/YubiKey authentication
    ../dns # DNS configuration with DNSSEC

    # Common flake modules used across all systems
    inputs.disko.nixosModules.disko # Disk configuration
    inputs.flatpaks.nixosModules.nix-flatpak
    inputs.lanzaboote.nixosModules.lanzaboote
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

  # Basic nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
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

  # Global system state version
  system.stateVersion = lib.mkDefault "25.05";
}
