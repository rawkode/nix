# Plymouth boot splash configuration
{ config, lib, pkgs, ... }:
{
  boot.plymouth = {
    enable = true;
    # Theme will be managed by stylix
  };

  # Ensure Plymouth starts early in boot process
  boot.initrd.systemd.enable = true;

  # Silent boot for cleaner Plymouth experience
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];

  # Hide systemd messages during boot
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
}
