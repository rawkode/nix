{
  flake.homeModules.desktop =
    { inputs, ... }:
    {
      imports = with inputs.self.homeModules; [
        onepassword
        alacritty
        clickup
        dconf-editor
        flatpak
        ghostty
        niri
        ptyxis
        rquickshare
        slack
        spotify
        tana
        visual-studio-code
        vivaldi
        wayland
        wezterm
        zed
        zoom
        zulip
      ];
    };
}
