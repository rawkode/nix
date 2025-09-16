{ inputs, ... }:
let
  # Shared stylix configuration used by both NixOS and Home Manager
  stylixConfig =
    { lib, pkgs, ... }:
    let
      wallpapers = {
        dark = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/ng-hai/hyper-rose-pine-next/refs/heads/main/wallpaper/dark/wallpaper-block-wave/themer-wallpaper-block-wave-dark-5120x2880.png";
          sha256 = "sha256-Q5ZtrIDtPZKOYohNt9NjPF6suV3rcw1HK8mx7+Ll4Ts=";
        };
        light = wallpapers.dark;
      };
    in
    {
      stylix = {
        enable = true;

        # Configure both light and dark themes
        theme = {
          light = {
            wallpaper = wallpapers.light;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-dawn.yaml";

            # Light mode icons - the existing module will use these
            icons = {
              package = pkgs.rose-pine-icon-theme;
              name = "rose-pine-dawn"; # Adjust if the theme has different variant names
            };

            cursor = {
              package = pkgs.rose-pine-cursor;
              name = "BreezeX-RosePineDawn-Linux"; # Adjust if cursor has light variant
              size = 32;
            };
          };

          dark = {
            wallpaper = wallpapers.dark;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";

            # Dark mode icons
            icons = {
              package = pkgs.rose-pine-icon-theme;
              name = "rose-pine-moon"; # Adjust if the theme has different variant names
            };

            cursor = {
              package = pkgs.rose-pine-cursor;
              name = "BreezeX-RosePine-Linux";
              size = 32;
            };
          };
        };

        opacity.terminal = 0.9;
        opacity.popups = 0.9;

        targets.qt.platform = lib.mkForce "qtct";

        fonts = {
          sizes = {
            applications = 11;
            terminal = 14;
            desktop = 12;
            popups = 11;
          };

          monospace = {
            package = pkgs.nerd-fonts.monaspace;
            name = "MonaspaceNeon Nerd Font";
          };

          serif = {
            package = pkgs.libre-baskerville;
            name = "Libre Baskerville";
          };

          sansSerif = {
            package = pkgs.quicksand;
            name = "Quicksand";
          };

          emoji = {
            package = pkgs.noto-fonts-emoji;
            name = "Noto Color Emoji";
          };
        };
      };
    };
in
{
  # NixOS module that imports both stylix and our config
  flake.nixosModules.stylix = {
    imports = [
      inputs.stylix.nixosModules.stylix
      stylixConfig
    ];
  };

  # Home Manager module that imports both stylix and our config
  flake.homeModules.stylix = {
    imports = [
      inputs.stylix.homeModules.stylix
      stylixConfig
    ];
  };
}
