{ ... }:
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
    # ./portals  # Removed: Now handled by shared/portals.nix via NixOS modules
    ./ptyxis
    ./rquickshare
    ./slack
    ./spotify
    ./tana
    ./visual-studio-code
    ./vivaldi
    ./warp
    ./wayland
    ./wezterm
    ./zed
    ./zoom
    ./zulip
  ];
}
