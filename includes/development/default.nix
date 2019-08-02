{ config, pkgs, ... }:

{
  imports =
    [
      ./git.nix
    ];

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

    # Go
    go

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
