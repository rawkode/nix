{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
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
    gnome3.dconf
    gnome3.vte
  ]);

  environment.interactiveShellInit = ''
    if [[ "$VTE_VERSION" > 3405 ]]; then
      source "${pkgs.gnome3.vte}/etc/profile.d/vte.sh"
    fi
  '';

  fonts = {
    enableFontDir = true;

    fonts = with pkgs; [
      cascadia-code
      corefonts
      emojione
      google-fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Cascadia Code" ];
        sansSerif = [ "Bitter" ];
        serif     = [ "Bitter" ];
      };
    };
  };

  services.printing.enable = true;
  services.pcscd.enable = true;

  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };

  i18n.consoleUseXkbConfig = true;

  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gnome3.gnome-keyring.enable = true;

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
      gnome3.enable = true;
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
    docker = {
      enable = true;
      storageDriver = "devicemapper";
    };
  };

  nix.trustedUsers = ["rawkode"];

  system.stateVersion = "19.09";
}
