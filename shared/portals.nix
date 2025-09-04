{ lib, pkgs, ... }:
let
  # Portal backend configurations
  portalConfigs = {
    # Performance-optimized configuration for niri
    niri = {
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
    wlr = {
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

  # Default to niri config for optimal performance
  selectedConfig = portalConfigs.niri;
in
{
  # System-level portal configuration (for NixOS modules)
  systemPortals = {
    xdg.portal = {
      enable = true;
      inherit (selectedConfig) extraPortals config;
    };
  };

  # User-level portal configuration (for Home Manager modules)
  userPortals = {
    xdg.portal = {
      enable = true;
      inherit (selectedConfig) extraPortals config;
    };
  };

  # Export the selected configuration for direct access
  inherit selectedConfig;
}
