{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  fileSystems."/".options = [ "noatime" "nodiratime" ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };

      efi = {
        canTouchEfiVariables = true;
      };
    };

    cleanTmpDir = true;
  };

  i18n = {
    defaultLocale = "en_GB.UTF-8";
  };

  networking = {
    hostName = "p4x-639";

    networkmanager = {
      enable = true;
    };

    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.extraConfig = "
    [General]
    Enable=Source,Sink,Media,Socket
  ";

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # List packages installed in system profile.
  environment.systemPackages = (with pkgs; [
    asciinema
    autorandr
    blueman
    clipit
    compton
    dunst
    flameshot
    gnome3.dconf
    gnome3.vte
    gnupg
    insomnia
    networkmanagerapplet
    nitrogen
    nix-prefetch-git
    pamix
    stdenv
    vlc
    # i3
    i3
    i3lock
    # This is required for i3 support in polybar
    jsoncpp
    pinentry
    polybar
    rofi
  ]);

  environment.interactiveShellInit = ''
    if [[ "$VTE_VERSION" > 3405 ]]; then
      source "${pkgs.gnome3.vte}/etc/profile.d/vte.sh"
    fi
  '';

  fonts = {
    enableCoreFonts = true;
    fonts = [
      pkgs.google-fonts
      pkgs.nerdfonts
      pkgs.noto-fonts
    ];
  };

  services.printing.enable = true;

  services.pcscd.enable = true;
  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs.gnupg.agent.enable = false;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };

    libinput = {
      enable = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
    };
  };

  users.groups.rawkode = {};

  users.users.rawkode = {
    isNormalUser = true;
    home = "/home/rawkode";
    description = "David McKay";
    extraGroups = [ "rawkode" "audio" "disk" "docker" "networkmanager" "plugdev" "wheel" ];
    shell = pkgs.zsh;
  };

  virtualisation = {
    virtualbox.host = {
      enable = true;
      enableHardening = false;
      addNetworkInterface = true;
    };

    docker = {
      enable = true;
      storageDriver = "devicemapper";
    };
  };

  system.stateVersion = "18.09";
}
