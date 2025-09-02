# Desktop applications and environments
{ config, lib, pkgs, ... }:

{
  imports = [
    ./1password
    ./alacritty
    ./clickup
    ./dconf-editor
    ./firefox
    ./flatpak
    ./ghostty
    ./gnome
    ./niri
    ./portals
    ./ptyxis
    ./rquickshare
    ./slack
    ./spotify
    ./tana
    ./visual-studio-code
    ./vivaldi
    ./waybar
    ./wayland
    ./wezterm
    ./zed
    ./zoom
    ./zulip
  ];
}