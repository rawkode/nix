_:
{
  flake.homeModules.command-line-cuenv =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [ inputs.cuenv.packages.${system}.cuenv ];
      programs.fish.interactiveShellInit = "cuenv shell init fish | source";
    };
}
