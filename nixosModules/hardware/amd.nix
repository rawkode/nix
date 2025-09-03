# AMD hardware configuration
{
  config,
  lib,
  pkgs,
  ...
}:
{
  # AMD CPU
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot = {
    kernelModules = [
      "kvm-amd"
      "amd-pstate"
      "zenpower"
      "msr"
    ];
    kernelParams = [ "amd_pstate=active" ];
  };

  # AMD GPU support
  services.xserver.videoDrivers = lib.mkDefault [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr
      rocmPackages.clr.icd
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  # AMD-specific packages
  environment.systemPackages = with pkgs; [
    ryzenadj
    zenmonitor
    radeontop
    corectrl
  ];

  # Enable corectrl for GPU control
  programs.corectrl = {
    enable = true;
  };

  # Enable GPU overclocking
  hardware.amdgpu.overdrive.enable = true;
}
