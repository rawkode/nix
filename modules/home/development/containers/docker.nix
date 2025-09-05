{ inputs, ... }:
{
  flake.homeModules.development-docker =
    { lib, pkgs, ... }:
    {
      home.packages = with pkgs; [
        docker-client
        docker-compose
      ];

      xdg.configFile."docker/config.json".text = ''
        {
          "auths": {},
          "credsStore": "secretservice"
        }
      '';
    };
}
