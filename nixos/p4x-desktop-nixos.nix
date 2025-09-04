# Desktop system configuration
{ inputs, ... }:
{
  system = "x86_64-linux";
  modules = [
    (
      {
        config,
        lib,
        modulesPath,
        pkgs,
        ...
      }:
      {
        imports = [
          # Desktop profile (includes base, audio, desktop environment)
          ../nixosModules/profiles/desktop.nix

          # AMD hardware profiles
          ../nixosModules/profiles/amd.nix # AMD CPU/GPU tools
          ../nixosModules/hardware/amd.nix # AMD hardware configuration
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-gpu-amd
          inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
        ];

        # System identity
        networking.hostName = "p4x-desktop-nixos";

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
                            mountOptions = [
                              "compress=zstd"
                              "noatime"
                            ];
                          };

                          "@persist" = {
                            mountpoint = "/persist";
                            mountOptions = [
                              "compress=zstd"
                              "noatime"
                            ];
                          };

                          "@nix" = {
                            mountpoint = "/nix";
                            mountOptions = [
                              "compress=zstd"
                              "noatime"
                            ];
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
        boot.kernelParams = [
          "video=DP-1:2160@144"
          "video=DP-2:3840x2160@144"
        ];

        # Lanzaboote replaces systemd-boot when secure boot is enabled
        # boot.loader.systemd-boot.enable is handled by lanzaboote

        # Networking optimization
        systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
        systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

        # Hardware configuration
        hardware.enableRedistributableFirmware = true;
        hardware.keyboard.qmk.enable = true;

        # Enable secure boot
        rawkOS.secureboot.enable = true;

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

      }
    )
  ];
}
