# p4x-desktop-nixos machine configuration - Dendritic pattern
{ inputs, ... }:
{
  flake.nixosConfigurations.p4x-desktop-nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with inputs; [
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
                        extraFormatArgs = [ "--pbkdf pbkdf2" ];
                        extraOpenArgs = [ "--allow-discards" ];
                        askPassword = true;
                        content = {
                          type = "btrfs";
                          extraArgs = [ "-f" ];
                          subvolumes = {
                            "@" = {
                              mountpoint = "/";
                              mountOptions = [
                                "compress=zstd"
                                "noatime"
                              ];
                            };
                            "@home" = {
                              mountpoint = "/home";
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
                            "@swap" = {
                              mountpoint = "/swap";
                              mountOptions = [ "noatime" ];
                              swap = {
                                swapfile.size = "16G";
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
