{ pkgs, self, ... }:
pkgs.runCommand "check-formatting"
{
  nativeBuildInputs = with pkgs; [
    nixpkgs-fmt
    biome
  ];
} ''
  echo "Checking Nix formatting..."
  nixpkgs-fmt --check ${self}/*.nix ${self}/nixos/*.nix ${self}/home/*.nix ${self}/nixosModules/*.nix ${self}/homeModules/*.nix
  
  echo "Checking other file formatting..."
  biome check ${self}
  
  touch $out
''
