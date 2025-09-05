_:
{
  flake.homeModules.desktop-portals =
    { pkgs, ... }:
    {
      # Optimal XDG desktop portals configuration for Niri with maximum performance
      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          kdePackages.xdg-desktop-portal-kde
          # Remove wlr to avoid conflicts - niri portal handles wlr functionality better
        ];
        config = {
          common = {
            default = [
              "gtk"
            ];
            "org.freedesktop.impl.portal.Secret" = [
              "kwallet"
            ];
          };
          niri = {
            # Prioritize niri portal for best performance, fallback to gtk
            default = [
              "niri"
              "gtk"
            ];
            "org.freedesktop.impl.portal.FileChooser" = [
              "gtk" # GTK file chooser is most reliable
            ];
            "org.freedesktop.impl.portal.Notification" = [
              "gtk" # GTK notifications work best
            ];
            "org.freedesktop.impl.portal.Screenshot" = [
              "niri" # Niri's native screenshot is fastest
            ];
            "org.freedesktop.impl.portal.ScreenCast" = [
              "niri" # Niri's native screencast is most efficient
            ];
            "org.freedesktop.impl.portal.Secret" = [
              "kwallet" # KDE Wallet for consistent secret management
            ];
          };
        };
      };
    };
}
