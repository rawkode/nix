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
    ../below          # System monitoring
    ../kernel/secureboot  # Secure Boot management
    ../tpm2           # TPM support
    
    # Security and networking
    ../u2f            # U2F/YubiKey authentication
    ../dns            # DNS configuration with DNSSEC
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
      automatic = lib.mkDefault true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}