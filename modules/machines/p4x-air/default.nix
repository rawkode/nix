{ inputs, ... }:
{
  flake.darwinConfigurations.p4x-air = inputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [
      inputs.home-manager.darwinModules.home-manager
      inputs.self.darwinModules.nix
      inputs.self.darwinModules.ghostty
      inputs.self.darwinModules.alt-tab
      inputs.self.darwinModules.fantastical
      inputs.self.darwinModules.fish
      inputs.self.darwinModules.user
      inputs.self.darwinModules.system-defaults
      inputs.self.darwinModules.firewall
      inputs.self.darwinModules.power
      inputs.self.darwinModules.fonts
      inputs.self.darwinModules.deskflow
      (
        { pkgs, ... }:
        {
          networking = {
            hostName = "p4x-air";
            localHostName = "p4x-air";
            computerName = "p4x-air";
          };

          programs.zsh.enable = true;
          environment.shells = [
            pkgs.zsh
            pkgs.bashInteractive
          ];

          security.pam.services.sudo_local.touchIdAuth = true;

          rawkOS.darwin = {
            systemDefaults = {
              enable = true;
              dock = {
                autohide = true;
                autohideDelay = 0.0;
                autohideTimeModifier = 0.15;
                orientation = "bottom";
                tilesize = 44;
                launchanim = false;
                minimizeToApplication = true;
                showProcessIndicators = true;
                showRecents = false;
                persistentApps = [ ];
                exposeAnimationDuration = 0.2;
                exposeGroupApps = true;
                mruSpaces = false;
                appswitcherAllDisplays = false;
                hotCornerTopLeft = 1;
                hotCornerTopRight = 12;
                hotCornerBottomLeft = 1;
                hotCornerBottomRight = 4;
              };
              finder = {
                showExtensions = true;
                showHiddenFiles = true;
                showPathBar = true;
                showStatusBar = true;
                defaultView = "Nlsv";
              };
              trackpad = {
                tapToClick = true;
                naturalScrolling = true;
                threeFingerDrag = true;
              };
              keyboard = {
                keyRepeat = 2;
                initialKeyRepeat = 15;
                disablePressAndHold = true;
              };
              screencapture = {
                format = "png";
                location = "~/Screenshots";
                disableShadow = true;
              };
              global = {
                darkMode = true;
              };
            };

            firewall = {
              enable = true;
              stealthMode = true;
              allowSigned = true;
              allowSignedApp = true;
            };

            power = {
              enable = true;
              displaySleep = 15;
              computerSleep = "never";
              harddiskSleep = "never";
            };

            fonts = {
              enable = true;
              packages = with pkgs; [
                monaspace
                nerd-fonts.monaspace
                nerd-fonts.symbols-only
              ];
            };
          };

          nix.enable = false; # Determinate packages supplies Nix daemon

          users.users.rawkode = {
            name = "rawkode";
            home = "/Users/rawkode";
          };

          system.primaryUser = "rawkode";
          system.stateVersion = 5;
        }
      )
    ];
  };

  flake.packages.aarch64-darwin.p4x-air = inputs.self.darwinConfigurations.p4x-air.system;
  flake.p4x-air = inputs.self.darwinConfigurations.p4x-air;
}
