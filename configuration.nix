{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    (builtins.fetchTarball {
      url = "https://github.com/msteen/nixos-vsliveshare/archive/e6ea0b04de290ade028d80d20625a58a3603b8d7.tar.gz";
      sha256 = "12riba9dlchk0cvch2biqnikpbq4vs22gls82pr45c3vzc3vmwq9";
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

    vscode
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

  services.vsliveshare = {
    enable = true;
    enableWritableWorkaround = true;
    enableDiagnosticsWorkaround = true;
    extensionsDir = "/home/rawkode/.vscode/extensions";
  };

  system.stateVersion = "19.03";
}
