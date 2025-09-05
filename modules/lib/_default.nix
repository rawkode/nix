# Custom library functions - Dendritic pattern
{ inputs, ... }:
{
  # Define custom library functions as a flake output
  flake.lib.rawkOS = {
    fileAsSeparatedString =
      path:
      inputs.nixpkgs.lib.strings.concatStringsSep "\n" (
        inputs.nixpkgs.lib.strings.splitString "\n" (builtins.readFile path)
      );
  };
}
