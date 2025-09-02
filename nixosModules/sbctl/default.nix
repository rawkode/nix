{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    sbctl
  ];

  # Note: systemd-boot configuration is handled by the system's boot loader module
  # (e.g., lanzaboote or systemd-boot directly)
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  # Note: Secure Boot configuration requires manual setup:
  # 1. sbctl create-keys
  # 2. sbctl enroll-keys --microsoft
  # 3. sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
  # 4. sbctl sign -s /boot/EFI/systemd/systemd-bootx64.efi
  # 5. sbctl sign -s /boot/EFI/Linux/*.efi
}