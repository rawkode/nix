_:
{
  flake.homeModules.command-line-git-delta = {
    programs.git.delta = {
      enable = true;

      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
      };
    };
  };
}
