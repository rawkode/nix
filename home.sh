#!/usr/bin/env sh
mkdir -p $HOME/.config/nixpkgs
cp ./rawkode.nix $HOME/.config/nixpkgs/home.nix
cp -R includes $HOME/.config/nixpkgs/

home-manager switch
