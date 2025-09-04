{ lib, pkgs, ... }:
{
  # Modern greetd setup with tuigreet - better for multi-monitor setups
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --asterisks";
        user = "greeter";
      };
    };
  };

  # Create the greeter user if it doesn't exist
  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
  };
  
  users.groups.greeter = {};
}