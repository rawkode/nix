{ inputs, ... }:
{
  flake.homeModules.command-line =
    # Command-line tools and utilities
    {
      inputs,
      config,
      lib,
      pkgs,
      ...
    }:

    {
      imports = with inputs.self.homeModules; [
        command-line-atuin
        command-line-bat
        command-line-btop
        command-line-carapace
        command-line-comma
        command-line-cue
        command-line-cuenv
        command-line-direnv
        command-line-eza
        command-line-fish
        command-line-git
        command-line-github
        command-line-google-cloud
        command-line-helix
        command-line-htop
        command-line-jj
        command-line-jq
        command-line-just
        command-line-lazyjournal
        command-line-misc
        command-line-nushell
        command-line-ripgrep
        command-line-runme
        command-line-starship
        command-line-television
        command-line-zellij
        command-line-zoxide
      ];
    };
}
