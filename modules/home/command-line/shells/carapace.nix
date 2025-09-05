_: {
  flake.homeModules.command-line-carapace = _: {
    programs.carapace = {
      enable = true;

      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
