{
  flake.nixosModules.wayland =
    _:
    {
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland";
      };
    };
}
