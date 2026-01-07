{
  flake.darwinModules.gcloud =
    { lib, ... }:
    {
      homebrew = {
        enable = lib.mkDefault true;
        casks = [ "google-cloud-sdk" ];
      };
    };
}
