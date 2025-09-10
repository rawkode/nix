{
  flake.homeModules.desktop-vicinae =
    { pkgs, ... }:
    {
      services.vicinae = {
        enable = true;
    	};
    };
}
