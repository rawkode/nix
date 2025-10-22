{ inputs, ... }:
{
  flake.darwinConfigurations.p4x-air = inputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    specialArgs = {
      inherit inputs;
    };
    modules = [
      inputs.home-manager.darwinModules.home-manager
      inputs.self.darwinModules.fonts
      inputs.self.darwinModules.ghostty
      inputs.self.darwinModules.alt-tab
      inputs.self.darwinModules.fantastical
      inputs.self.darwinModules.fish
      (
        { pkgs, ... }:
        {
          networking.hostName = "p4x-air";

          programs.zsh.enable = true;
          environment.shells = [
            pkgs.zsh
            pkgs.bashInteractive
          ];

          security.pam.services.sudo_local.touchIdAuth = true;
          system = {
            defaults = {
              dock = {
                appswitcher-all-displays = false;
                autohide = true;
                autohide-delay = 0.0;
                autohide-time-modifier = 0.15;
                orientation = "right";
                tilesize = 44;
                launchanim = false;
                minimize-to-application = true;
                show-process-indicators = true;
                show-recents = false;
                persistent-apps = [ ];
                expose-animation-duration = 0.2;
                expose-group-apps = true;
                wvous-bl-corner = 1;
                wvous-br-corner = 4;
                wvous-tl-corner = 1;
                wvous-tr-corner = 12;
                mru-spaces = false;
              };
            };
          };

          nix.enable = false; # Determinate packages supplies Nix daemon

          users.users.rawkode = {
            name = "rawkode";
            home = "/Users/rawkode";
            shell = pkgs.fish;
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
