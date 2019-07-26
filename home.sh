#!/usr/bin/env sh
mkdir -p $HOME/.config/nixpkgs
cp ./rawkode.nix $HOME/.config/nixpkgs/home.nix
cp -R includes $HOME/.config/nixpkgs/

if [[ ! -e $dir ]]; then
    export ZPLUG_HOME=$HOME/.zplug
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

home-manager switch
