{ config, pkgs, ... }:

{
  home.packages = (with pkgs; [
    #ant-theme
    arc-icon-theme
    arc-theme
    materia-theme
  ]);

  gtk = {
    enable = true;

    font = {
      name = "Bitter 11";
      package = pkgs.google-fonts;
    };

    theme = {
      name = "Arc-Darker";
    };

    iconTheme = {
      name = "Arc";
    };
  };

  xresources.properties = {
    "Xft.antialias" = 1;
    "Xft.autohint" = 0;
    "Xft.hinting" = 1;
    "Xft.hintstyle" = "hintfull";
    "Xft.lcdfilter" = "lcddefault";

    "Xcursor.theme" = "Bibata Oil";

    "*.foreground" =  "#d0d0d0";
    "*.background" = "#151515";
    "*.cursorColor" = "#d0d0d0";
    "*.color0" = "#151515";
    "*.color8" = "#505050";
    "*.color1" = "#ac4142";
    "*.color9" = "#ac4142";
    "*.color2" = "#90a959";
    "*.color10"= "#90a959";
    "*.color3" = "#f4bf75";
    "*.color11"= "#f4bf75";
    "*.color4" = "#6a9fb5";
    "*.color12"= "#6a9fb5";
    "*.color5" = "#aa759f";
    "*.color13"= "#aa759f";
    "*.color6" = "#75b5aa";
    "*.color14"= "#75b5aa";
    "*.color7" = "#d0d0d0";
    "*.color15" = "#f5f5f5";
  };
}
