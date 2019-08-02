{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      (builtins.fetchTarball {
        sha256 = "1qmq5zwd4qdxdxh4zxc7yr7qwajgnsjdw2npw0rfkyahmrqw3j02";
        url = "https://github.com/msteen/nixos-vsliveshare/archive/86624fe317c24df90e9451dd5741220c98d2249d.tar.gz";
      })
    ];

  fileSystems."/".options = [ "noatime" "nodiratime" ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

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
    hostName = "nixos";

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

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };

    useSandbox = true;

    package = pkgs.nixUnstable;
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # List packages installed in system profile.
  environment.systemPackages = (with pkgs; [
    asciinema
    autorandr
    blueman
    clipit
    flameshot
    gnome-mpv
    kbfs
    keybase
    keybase-gui
    mpv
    gnome3.dconf
    gnome3.vte
    gnupg
    insomnia
    nix-prefetch-git
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
    yubikey-personalization
  ]);

  services = {
    kbfs = {
      enable = true;
      mountPoint = "Keybase";
    };

    keybase = {
      enable = true;
    };
  };

  programs.sway.enable = true;

  environment.interactiveShellInit = ''
    if [[ "$VTE_VERSION" > 3405 ]]; then
      source "${pkgs.gnome3.vte}/etc/profile.d/vte.sh"
    fi
  '';

  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    fontconfig.ultimate = {
      enable = true;
      preset = "osx";
    };

    fonts = with pkgs; [
      emojione
      google-fonts
    ];
  };

  services.printing.enable = true;
  services.blueman-applet.enable = true;
  services.pcscd.enable = true;

  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];

  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };

  programs.gnupg.agent.enable = false;

  i18n.consoleUseXkbConfig = true;

  services.autorandr.enable = true;

  security.pam.services.gdm.enableGnomeKeyring = true;

  services.xserver = {
    enable = true;

    layout = "us";
    xkbVariant = "altgr-intl";

    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };

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

      # This only applies to the trackpad, need to check if we
      # can find a way to do this for mice too.
      naturalScrolling = true;
      scrollMethod = "twofinger";
      tapping = true;
      clickMethod = "clickfinger";
      disableWhileTyping = true;
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

  system.stateVersion = "19.03";
}
