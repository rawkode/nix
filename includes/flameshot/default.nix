{ config, pkgs, ... }:

{
  home.packages = (with pkgs; [
    flameshot
  ]);

  services = {
    flameshot = {
      enable = true;
    };
  };
}

