{ inputs, ... }:
{
  flake.homeModules.command-line-google-cloud =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
      ];
    };
}
