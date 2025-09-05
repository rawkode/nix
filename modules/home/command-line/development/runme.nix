_: {
  flake.homeModules.command-line-runme =
    { lib, pkgs, ... }:
    let
      fileAsSeparatedString =
        path: lib.strings.concatStringsSep "\n" (lib.strings.splitString "\n" (builtins.readFile path));
    in
    {
      home.packages = with pkgs; [ runme ];
      programs.fish.interactiveShellInit = fileAsSeparatedString ./runme/init.fish;
    };
}
