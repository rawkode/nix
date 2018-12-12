{ config, pkgs, ... }:

{
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

  programs.git = {
    enable = true;
    userName  = "David McKay";
    userEmail = "rawkode@pm.me";
  };

  # programs.home-manager = {
  #   enable = true;
  # };

  home.packages = (with pkgs; [
    # Core
    alacritty
    direnv
    exa
    fzf
    git
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
}
