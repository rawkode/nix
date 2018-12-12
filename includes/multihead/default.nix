{ config, pkgs, ... }:

{
  home.packages = (with pkgs; [
    autorandr
    # Not merged yet
    #lxrandr
  ]);

  programs = {
    autorandr = {
      enable = true;
    };
  };
}
