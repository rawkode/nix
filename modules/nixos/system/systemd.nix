_: {
  flake.nixosModules.systemd = _: {
    systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
  };
}
