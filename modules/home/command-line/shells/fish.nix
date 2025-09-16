{
  flake.homeModules.fish =
    { lib, pkgs, ... }:
    let
      fileAsSeparatedString =
        path: lib.strings.concatStringsSep "\n" (lib.strings.splitString "\n" (builtins.readFile path));
    in
    {
      home.file.".bashrc".source = ./fish/auto-fish.sh;

      programs.fish = {
        enable = true;

        plugins = [
          {
            name = "nix-env";
            src = pkgs.fetchFromGitHub {
              owner = "lilyball";
              repo = "nix-env.fish";
              rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
              hash = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk";
            };
          }
        ];

        shellAliases = {
          ghb = "cd ~/Code/src/github.com";
        };

        binds = {
          "ctrl-\\[".command = "builtin cd ..; commandline -f repaint";
        };

        interactiveShellInit = fileAsSeparatedString ./fish/interactiveInit.fish;

        functions = {
          magic-enter = {
            description = "Magic Enter";
            body = fileAsSeparatedString ./fish/magic-enter.fish;
          };

          magic-enter-command = {
            description = "Magic Enter AutoCommands";
            body = fileAsSeparatedString ./fish/magic-enter-command.fish;
          };
        };
      };
    };
}
