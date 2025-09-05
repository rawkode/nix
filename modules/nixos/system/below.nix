_: {
  flake.nixosModules.below = _: {
    services.below.enable = true;
  };
}
