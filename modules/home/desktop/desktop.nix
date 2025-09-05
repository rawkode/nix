_:
{
  flake.homeModules.desktop =
    { inputs, ... }:
    {
      imports = with inputs.self.homeModules; [
        desktop-1password
        desktop-alacritty
        desktop-clickup
        desktop-dconf-editor
        desktop-firefox
        desktop-flatpak
        desktop-ghostty
        desktop-gnome
        desktop-niri
        # desktop-portals  # Removed: Now handled by shared/portals.nix via NixOS modules
        desktop-ptyxis
        desktop-rquickshare
        desktop-slack
        desktop-spotify
        desktop-tana
        desktop-visual-studio-code
        desktop-vivaldi
        desktop-wayland
        desktop-wezterm
        desktop-zed
        desktop-zoom
        desktop-zulip
      ];
    };
}
