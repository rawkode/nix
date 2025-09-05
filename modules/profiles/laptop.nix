# Laptop profile relocated
_:
{
  flake.nixosModules.profiles-laptop =
    {
      pkgs,
      ...
    }:
    {
      imports = [ ./desktop.nix ];

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

      environment.systemPackages = with pkgs; [
        powertop
        acpi
        brightnessctl
      ];

      networking.networkmanager = {
        enable = true;
        wifi.powersave = true;
      };

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
