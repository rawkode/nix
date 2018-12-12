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
}
