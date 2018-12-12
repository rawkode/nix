#!/usr/bin/env sh
sudo cp ./configuration.nix /etc/nixos/

sudo nixos-rebuild switch

sudo nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

nix-shell '<home-manager>' -A install

source ./home.sh
