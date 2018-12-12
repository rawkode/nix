{ config, pkgs, ... }:

{
  home.file.".config/alacritty/alacritty.yml".source = ./config.yml;

  home.packages = (with pkgs; [
    alacritty
  ]);
}
