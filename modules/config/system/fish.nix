{
  flake.nixosModules.fish = {
    programs.fish.enable = true;
    stylix.targets.fish.enable = false;
  };
}
