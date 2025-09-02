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