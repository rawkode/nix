_: {
  flake.nixosModules.polkit = { ... }: {
    # Ensure the system-wide polkit daemon is running
    security.polkit.enable = true;
  };
}

