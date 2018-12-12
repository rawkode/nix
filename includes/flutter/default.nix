{ config, pkgs, ... }:

{
  nixpkgs.config = {
    android_sdk = {
      accept_license = true;
    };
  };

  home.packages = (with pkgs; [
    androidsdk
    dart
    # Not available yet
    #flutter
  ]);
}
