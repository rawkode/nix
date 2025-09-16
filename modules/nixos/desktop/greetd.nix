{
  flake.nixosModules.greetd =
    { pkgs, ... }:
    {
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --asterisks";
            user = "greeter";
          };
        };
      };

      users.users.greeter = {
        isSystemUser = true;
        group = "greeter";
      };

      users.groups.greeter = { };
    };
}
