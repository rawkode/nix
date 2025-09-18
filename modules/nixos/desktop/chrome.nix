{
  flake.nixosModules.chrome =
    { pkgs, inputs, ... }:
    {
      stylix.targets.chromium.enable = false;
      environment.systemPackages =
        with inputs.browser-previews.packages.${pkgs.stdenv.hostPlatform.system}; [
          google-chrome-dev
        ];
    };
}
