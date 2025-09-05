# Framework laptop system configuration (p4x-laptop) - Dendritic pattern
{ inputs, ... }:
{
  flake.nixosConfigurations.p4x-laptop-nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      # Hardware modules
      inputs.nixos-hardware.nixosModules.framework-13-7040-amd

      # Flake inputs
      inputs.disko.nixosModules.disko
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.nixos-cosmic.nixosModules.default
      inputs.flatpaks.nixosModules.nix-flatpak

      # Import profiles
      inputs.self.nixosModules.profiles-laptop
      inputs.self.nixosModules.profiles-framework

      # Machine-specific configuration
      (
        {
          config,
          lib,
          modulesPath,
          pkgs,
          ...
        }:
        {
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

          # Hardware configuration
          hardware.enableRedistributableFirmware = true;
          hardware.cpu.amd.updateMicrocode = true;
          hardware.keyboard.qmk.enable = true;
          hardware.graphics.enable = true;

          # Swap
          swapDevices = [
            {
              device = "/var/lib/swapfile";
              size = 48 * 1024;
            }
          ];

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
    specialArgs = {
      inherit inputs;
    };
  };
}
