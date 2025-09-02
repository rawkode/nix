# Framework laptop system configuration (p4x-laptop)
{ inputs, ... }:
{
  system = "x86_64-linux";
  modules = [
    ({ config, lib, modulesPath, pkgs, ... }: {
      imports = [
        # Base modules
        (modulesPath + "/installer/scan/not-detected.nix")
        
        # Disk configuration
        inputs.disko.nixosModules.disko
        
        # Flake modules
        inputs.auto-cpufreq.nixosModules.default
        inputs.flatpaks.nixosModules.nix-flatpak
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.niri.nixosModules.niri
        inputs.nur.modules.nixos.default
        inputs.stylix.nixosModules.stylix
        inputs.nix-index-database.nixosModules.nix-index
        
        # Framework profile (includes laptop, desktop, development, AMD hardware)
        ../nixosModules/profiles/framework.nix
      ];

      # System identity
      networking.hostName = "p4x-laptop-nixos";

      # Disko configuration
      disko.devices = {
        disk = {
          root = {
            type = "disk";
            device = "/dev/nvme0n1";
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  priority = 1;
                  name = "esp";
                  size = "512M";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "defaults" ];
                  };
                };

                luks = {
                  size = "100%";
                  content = {
                    type = "luks";
                    name = "encrypted";
                    askPassword = true;
                    extraFormatArgs = [
                      "--type luks2"
                      "--cipher aes-xts-plain64"
                      "--hash sha512"
                      "--iter-time 5000"
                      "--key-size 256"
                      "--pbkdf argon2id"
                      "--use-random"
                    ];
                    settings = {
                      allowDiscards = true;
                    };
                    content = {
                      type = "btrfs";
                      extraArgs = [ "-f" ];
                      subvolumes = {
                        "@root" = {
                          mountpoint = "/";
                          mountOptions = [ "compress=zstd" "noatime" ];
                        };
                        "@persist" = {
                          mountpoint = "/persist";
                          mountOptions = [ "compress=zstd" "noatime" ];
                        };
                        "@nix" = {
                          mountpoint = "/nix";
                          mountOptions = [ "compress=zstd" "noatime" ];
                        };
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };

      # Boot configuration
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.efi.efiSysMountPoint = "/boot";

      # Swap
      swapDevices = [{
        device = "/var/lib/swapfile";
        size = 96 * 1024;
      }];

      # Framework-specific overrides
      programs.auto-cpufreq = {
        enable = true;
        settings = {
          charger = {
            governor = "performance";
            turbo = "auto";
          };
          battery = {
            governor = "powersave";
            turbo = "never";
          };
        };
      };

      # Nix settings
      nix.settings = {
        substituters = [
          "https://niri.cachix.org"
          "https://wezterm.cachix.org"
        ];
        trusted-public-keys = [
          "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
          "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
        ];
      };

      nix.registry = {
        nixpkgs.flake = inputs.nixpkgs;
        rawkode.flake = inputs.self;
        templates.flake = inputs.self;
      };

      system.stateVersion = "25.05";
    })
  ];
}