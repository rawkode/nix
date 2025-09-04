# jq - Command-line JSON processor
{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
  ];
}