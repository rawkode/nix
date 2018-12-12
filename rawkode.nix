{ config, pkgs, ... }:

let
  nixpkgs = import ../nixpkgs;

  isDir = path: builtins.pathExists (path + "/.");

  include = path:
    if isDir path
    then
      let
        content = builtins.readDir path;
      in
        map (n: import (path + ("/" + n)))
            (builtins.filter (n: builtins.match ".*\\.nix" n != null || builtins.pathExists (path + ("/" + n + "/default.nix")))
                    (builtins.attrNames content))
    else
    import path;
in {
  nixpkgs.config = {
    allowUnfree = true;

    android_sdk = {
      accept_license = true;
    };
  };

  fonts.fontconfig = {
    enableProfileFonts = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "Bitter 11";
      package = pkgs.google-fonts;
    };

    theme = {
      name = "Arc-Darker";
      package = pkgs.arc-theme;
    };

    iconTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
    };
  };

  services = {
    keybase.enable = true;
    kbfs.enable = true;
  };

  # programs.home-manager = {
  #   enable = true;
  # };

  home.packages = (with pkgs; [
    direnv
    exa
    fzf
    gnumake
    jq
    lxappearance
    ripgrep
    tldr
    unzip
    vim
    vscode
    wget
    zsh
  ] ++ [
    # Android
    androidsdk
  ] ++ [
    # Communication
    slack
    wavebox
  ] ++ [
    # Crystal
    crystal
    shards
  ] ++ [
    # Dart
    dart
  ] ++ [
    # Docker
    docker_compose
  ] ++ [
    # Go
    go
  ] ++ [
    # Google Cloud
    google-cloud-sdk
  ] ++ [
    # JavaScript
    nodejs
    yarn
  ] ++ [
    # Keybase
    kbfs
    keybase
    keybase-gui
  ] ++ [
    # Kubernetes
    kubectl
    kubernetes-helm
  ] ++ [
    # Pony
    ponyc
    pony-stable
  ] ++ [
    # Rust
    rustup
  ] ++ [
    # Web Browsers
    chromium
    firefox
  ]);

  imports = include ./includes;
}

