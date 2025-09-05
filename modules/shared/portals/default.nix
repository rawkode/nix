# Shared portal configurations - Dendritic pattern flake-parts module
_:
let
  # Portal backend configurations
  portalConfigs = {
    # Performance-optimized configuration for niri
    niri =
      { pkgs }:
      {
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          kdePackages.xdg-desktop-portal-kde
          # Note: xdg-desktop-portal-wlr removed to avoid conflicts with niri portal
        ];
        config = {
          common = {
            default = [ "gtk" ];
            "org.freedesktop.impl.portal.Secret" = [ "kwallet" ];
          };
          niri = {
            # Prioritize niri portal for best performance, fallback to gtk
            default = [
              "niri"
              "gtk"
            ];
            "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
            "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
            "org.freedesktop.impl.portal.Screenshot" = [ "niri" ];
            "org.freedesktop.impl.portal.ScreenCast" = [ "niri" ];
            "org.freedesktop.impl.portal.Secret" = [ "kwallet" ];
          };
        };
      };

    # Fallback configuration with wlr support
    wlr =
      { pkgs }:
      {
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
        ];
        config.niri = {
          default = [
            "kde"
            "gtk"
            "wlr"
          ];
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
          "org.freedesktop.impl.portal.Notification" = "gtk";
          "org.freedesktop.impl.portal.Secret" = "kwallet";
          "org.freedesktop.impl.portal.ScreenCast" = "wlr";
          "org.freedesktop.impl.portal.Screenshot" = "wlr";
        };
      };
  };
in
{
  # Define portal configuration module for NixOS
  flake.nixosModules.portals =
    { pkgs, ... }:
    let
      # Default to niri config for optimal performance
      selectedConfig = portalConfigs.niri { inherit pkgs; };
    in
    {
      xdg.portal = {
        enable = true;
        inherit (selectedConfig) extraPortals config;
      };
    };

  # Define portal configuration module for Home Manager
  flake.homeModules.portals =
    { pkgs, ... }:
    let
      # Default to niri config for optimal performance
      selectedConfig = portalConfigs.niri { inherit pkgs; };
    in
    {
      xdg.portal = {
        enable = true;
        inherit (selectedConfig) extraPortals config;
      };
    };
}
