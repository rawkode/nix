{ config, pkgs, ... }:

{
  home.packages = (with pkgs; [
    kbfs
    keybase
    keybase-gui
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
}
