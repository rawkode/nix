{ config, pkgs, ... }:

{
  nixpkgs.config = {
    android_sdk = {
      accept_license = true;
    };
  };

  home.packages = (with pkgs; [
    # Crystal
    crystal
    shards

    # Dart
    dart

    # Flutter
    # flutter

    # JavaScript
    nodejs
    yarn

    # Pony
    ponyc
    pony-stable

    # Python
    pipenv
    python
    pythonPackages.virtualenv

    # Rust
    rustup
  ]);
}
