{ inputs, ... }:
{
  flake.nixosModules.profiles-laptop =
    # Laptop profile - power management and mobile features
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:
    {
      imports = [
        ./desktop.nix
        # inputs.self.nixosModules.networking/tailscale  # Now in base profile
      ];

      # Power management
      services = {
        thermald.enable = true;

        upower = {
          enable = true;
          percentageLow = 15;
          percentageCritical = 7;
          percentageAction = 5;
          criticalPowerAction = "Hibernate";
        };

        logind = {
          lidSwitch = "suspend-then-hibernate";
          lidSwitchExternalPower = "lock";
          settings.Login = {
            HandlePowerKey = "suspend-then-hibernate";
            HibernateDelaySec = 3600;
          };
        };
      };

      # Laptop-specific packages
      environment.systemPackages = with pkgs; [
        powertop
        acpi
        brightnessctl
      ];

      # Network power saving
      networking.networkmanager = {
        enable = true;
        wifi.powersave = true;
      };

      # Enable touchpad support
      services.libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
          tapping = true;
          clickMethod = "clickfinger";
          disableWhileTyping = true;
        };
      };
    };
}
