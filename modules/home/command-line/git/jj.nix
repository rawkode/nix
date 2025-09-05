_: {
  flake.homeModules.command-line-jj = _: {
    programs.jujutsu = {
      enable = true;
    };
  };
}
