# Base profile - included in all systems
{ config, lib, pkgs, ... }:
{
  imports = [
    ../common
    ../nix
    ../networking
    ../user
    ../sudo
    ../systemd
    
    # Essential services for all hosts
    ../containers      # Docker & Podman
    ../tailscale      # VPN networking
    ../power-profiles-daemon  # Power management
    ../below          # System monitoring
    ../kernel/secureboot  # Secure Boot management
    ../tpm2           # TPM support
  ];

  # Essential packages for all systems
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    curl
    wget
  ];

  # Basic nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}