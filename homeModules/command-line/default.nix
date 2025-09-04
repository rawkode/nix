# Command-line tools and utilities
{ config, lib, pkgs, ... }:

{
  imports = [
    ./atuin
    ./bat
    ./btop
    ./carapace
    ./comma
    ./cue
    ./cuenv
    ./direnv
    ./eza
    ./fish
    ./git
    ./github
    ./google-cloud
    ./helix
    ./htop
    ./jj
    ./jq
    ./just
    ./lazyjournal
    ./misc
    ./nushell
    ./ripgrep
    ./runme
    ./starship
    ./television
    ./yazi
    ./zellij
    ./zoxide
  ];
}
