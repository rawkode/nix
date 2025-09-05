{ inputs, ... }:
{
  flake.nixosModules.chrome =
    { pkgs, inputs, ... }:
    {
      environment.systemPackages =
        with inputs.browser-previews.packages.${pkgs.stdenv.hostPlatform.system}; [
          google-chrome-dev # Dev Release
        ];
    };
}
