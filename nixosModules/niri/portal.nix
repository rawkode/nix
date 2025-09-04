{ lib, pkgs, ... }:
let
  portals = import ../../shared/portals.nix { inherit lib pkgs; };
in
portals.systemPortals
