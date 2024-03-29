{ pkgs, ... }:

let theme = (import ./themes/brewer.nix).theme;
in {
  home.packages = (with pkgs; [
    arc-icon-theme
    arc-theme
    bibata-cursors
    gnome3.gnome-tweaks
    materia-theme
  ]);

  gtk = {
    enable = true;

    font = {
      name = "Cascadia Code 11";
    };

    theme = {
      name = "Arc-Darker";
    };

    iconTheme = {
      name = "Arc";
    };
  };

  programs.termite = {
    enable = true;
    font = "Cascadia Code, 11";

    backgroundColor = "rgba(63, 63, 63, 0.8)";
  };
}
