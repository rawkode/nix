_:
{
  flake.homeModules.desktop-zulip =
    _:
    {
      services.flatpak.packages = [
        "org.zulip.Zulip"
      ];
    };
}
