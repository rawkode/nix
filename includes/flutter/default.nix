{ config, pkgs, ... }:

{
  home.packages = (with pkgs; [
    androidsdk
    dart
    # Not available yet
    #flutter
  ]);
}
