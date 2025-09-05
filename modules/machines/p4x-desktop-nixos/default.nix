# p4x-desktop-nixos machine configuration - Dendritic pattern
{ inputs, ... }:
{
  flake.nixosConfigurations.p4x-desktop-nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with inputs; [
      ({
        nixpkgs.overlays = [
          (final: prev: {
            cue = inputs.cue.legacyPackages.${prev.system}.cue;
          })
        ];
      })
      # Hardware modules
      nixos-hardware.nixosModules.common-pc-ssd
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-gpu-amd
      nixos-hardware.nixosModules.common-cpu-amd-pstate

      # Flake inputs
      disko.nixosModules.disko
      lanzaboote.nixosModules.lanzaboote
      nixos-cosmic.nixosModules.default
      flatpaks.nixosModules.nix-flatpak

      # Import profiles
      self.nixosModules.kernel
      self.nixosModules.lanzaboote
      self.nixosModules.plymouth
      self.nixosModules.profiles-desktop
      self.nixosModules.profiles-amd

      # Machine-specific configuration
      (
        { lib, ... }:
        {
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

          # Enable NetworkManager
          networking.networkmanager.enable = true;

          # Enable swap
          zramSwap.enable = true;

          # AMD-specific
          hardware.enableRedistributableFirmware = lib.mkDefault true;
        }
      )
    ];
    specialArgs = {
      inherit inputs;
    };
  };
}
