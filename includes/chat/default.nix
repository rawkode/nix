{ config, pkgs, ... }:

{
  home.packages = (with pkgs; [
    #nheko
    signal-desktop
    slack
    #spectral
    wavebox
    zoom-us
  ]);
}
