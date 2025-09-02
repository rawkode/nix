# DevShells for flakelight auto-discovery
# Each attribute is a devShell
{
  default = { pkgs, mkShell, ... }: mkShell {
    packages = with pkgs; [
      biome
      cue
      nh
      nixfmt-rfc-style
      nixpkgs-fmt
      nil
      nix-tree
      nix-diff
      statix
    ];
    
    env = {
      FLAKE_ROOT = "$PWD";
    };
    
    shellHook = ''
      echo "Welcome to rawkOS development shell!"
      echo "Run 'nix flake show' to see available outputs"
    '';
  };
}
