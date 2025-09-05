{ inputs, ... }:
{
  flake.homeModules.desktop-zulip =
    { ... }:
    {
      services.flatpak.packages = [
        "org.zulip.Zulip"
      ];
    };
}
