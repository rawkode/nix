{ inputs, ... }:
{
  # Expose a COSMIC overlay that sources packages from the nixpkgs PR
  # so modules can reference `inputs.self.overlays.cosmic`.
  flake.overlays.cosmic =
    final: _prev:
    let
      cosmic = inputs.nixpkgs-cosmic.legacyPackages.${final.system};
    in
    {
      inherit (cosmic)
        cosmic-session
        cosmic-comp
        cosmic-panel
        cosmic-launcher
        cosmic-settings
        cosmic-settings-daemon
        cosmic-term
        cosmic-files
        cosmic-applets
        cosmic-applibrary
        cosmic-bg
        cosmic-greeter
        cosmic-icons
        cosmic-idle
        cosmic-notifications
        cosmic-osd
        cosmic-randr
        cosmic-screenshot
        cosmic-workspaces-epoch
        xdg-desktop-portal-cosmic
        ;
    };

  flake.nixosModules.cosmic-desktop =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.programs.cosmic-desktop;
    in
    {
      options.programs.cosmic-desktop = {
        enable = lib.mkEnableOption "COSMIC desktop environment";

        packages = lib.mkOption {
          type = lib.types.listOf lib.types.package;
          default = with pkgs; [
            cosmic-session
            cosmic-comp
            cosmic-panel
            cosmic-launcher
            cosmic-settings
            cosmic-settings-daemon
            cosmic-term
            cosmic-files
            cosmic-applets
            cosmic-applibrary
            cosmic-bg
            cosmic-greeter
            cosmic-icons
            cosmic-idle
            cosmic-notifications
            cosmic-osd
            cosmic-randr
            cosmic-screenshot
            cosmic-workspaces-epoch
            xdg-desktop-portal-cosmic
          ];
          description = "COSMIC desktop packages to install";
        };
      };

      config = lib.mkIf cfg.enable {
        # Apply the COSMIC overlay
        nixpkgs.overlays = [ inputs.self.overlays.cosmic ];

        # Install COSMIC packages
        environment.systemPackages = cfg.packages;

        # Enable required services
        services.xserver.enable = lib.mkDefault true;
        # Note: don't auto-enable cosmic-greeter to avoid conflicts with custom greetd setups.
        # Users can enable `services.displayManager.cosmic-greeter.enable = true;` explicitly if desired.
        services.displayManager.cosmic-greeter.enable = lib.mkDefault false;

        # Set COSMIC as the desktop session
        services.displayManager.defaultSession = lib.mkDefault "cosmic";

        # Enable Wayland support
        programs.xwayland.enable = lib.mkDefault true;

        # XDG portal for COSMIC
        xdg.portal = {
          enable = true;
          extraPortals = [ pkgs.xdg-desktop-portal-cosmic ];
          config.cosmic = {
            default = [
              "cosmic"
              "gtk"
            ];
          };
        };
      };
    };
}
