_: {
  flake.homeModules.command-line-misc =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        tldr
        unzip
        vim
      ];

      programs.fzf.enable = true;
      programs.skim.enable = true;
    };
}
