_:
{
  flake.homeModules.command-line-git-jujutsu =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ jujutsu ];
      xdg.configFile."jj/config.toml".source = ./jj.toml;
    };
}
