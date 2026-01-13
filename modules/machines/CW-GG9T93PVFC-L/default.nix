{ inputs, ... }:
{
  flake.darwinConfigurations.CW-GG9T93PVFC-L = inputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [
      inputs.home-manager.darwinModules.home-manager
      inputs.self.darwinModules.nix
      inputs.self.darwinModules.users-dflanagan

      # System configuration
      inputs.self.darwinModules.fish
      inputs.self.darwinModules.user
      inputs.self.darwinModules.system-defaults
      inputs.self.darwinModules.power
      inputs.self.darwinModules.fonts

      # AI & Dev Tools
      inputs.self.darwinModules.ai
      inputs.self.darwinModules.zed
      # inputs.self.darwinModules.visual-studio-code  # Temporarily disabled - cask download failing

      # Terminals
      inputs.self.darwinModules.ghostty

      # Browsers
      inputs.self.darwinModules.google-chrome

      # Communication
      inputs.self.darwinModules.slack
      inputs.self.darwinModules.mimestream

      # Productivity & Utilities
      inputs.self.darwinModules.onepassword
      inputs.self.darwinModules.alt-tab
      inputs.self.darwinModules.fantastical
      inputs.self.darwinModules.setapp
      inputs.self.darwinModules.skim
      inputs.self.darwinModules.dockdoor
      inputs.self.darwinModules.parallels
      inputs.self.darwinModules.descript

      # Development
      inputs.self.darwinModules.docker
      inputs.self.darwinModules.gcloud
      inputs.self.darwinModules.deskflow
      (
        { pkgs, ... }:
        {
          networking = {
            hostName = "CW-GG9T93PVFC-L";
            localHostName = "CW-GG9T93PVFC-L";
            computerName = "CW-GG9T93PVFC-L";
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

          rawkOS.user.username = "dflanagan";

          nix.enable = false; # Determinate packages supplies Nix daemon

          users.users.dflanagan = {
            name = "dflanagan";
            home = "/Users/dflanagan";
          };

          system.primaryUser = "dflanagan";
          system.stateVersion = 5;
        }
      )
    ];
  };

  flake.packages.aarch64-darwin.CW-GG9T93PVFC-L = inputs.self.darwinConfigurations.CW-GG9T93PVFC-L.system;
  flake.CW-GG9T93PVFC-L = inputs.self.darwinConfigurations.CW-GG9T93PVFC-L;
}
