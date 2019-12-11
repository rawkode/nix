{ pkgs, ... }:

let theme = (import ./themes/brewer.nix).theme;
in {
  home.packages = (with pkgs; [
    arc-icon-theme
    arc-theme
    bibata-cursors
    font-awesome_5
    google-fonts
    gnome3.gnome-tweaks
    materia-theme
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ]);

  gtk = {
    enable = true;

    font = {
      name = "Cascadia Code 11";
      package = pkgs.cascadia-code;
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
