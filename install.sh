#!/usr/bin/env sh
sudo cp ./configuration.nix /etc/nixos/

sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
sudo nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
sudo nixos-rebuild switch --upgrade

nix-shell '<home-manager>' -A install

source ./home.sh
