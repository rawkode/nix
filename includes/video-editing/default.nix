{ config, pkgs, ... }:

with pkgs;
{
  home.packages = (with pkgs; [
    #shotcut
  ]);
}
