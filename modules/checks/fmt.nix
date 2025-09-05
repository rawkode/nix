_: {
  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";

        programs = {
          nixfmt = {
            enable = true;
            package = pkgs.nixfmt-rfc-style;
          };
          shellcheck.enable = true;
          shfmt = {
            enable = true;
            indent_size = null; # respect .editorconfig
          };
          statix.enable = true;
          deadnix.enable = true;
          biome = {
            enable = true;
            settings = {
              formatter = {
                useEditorconfig = true;
              };
            };
          };
          taplo.enable = true;
        };
      };
    };
}
