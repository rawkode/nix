# Nix tools module
{ config, lib, pkgs, ... }:
{
  imports = [ ./nix/default.nix ];
}