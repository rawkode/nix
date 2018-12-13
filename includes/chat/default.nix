{ config, pkgs, ... }:

{
  home.packages = (with pkgs; [
    signal-desktop
    slack
    wavebox
  ]);
}
