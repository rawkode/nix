{ config, pkgs, ... }:

{
  home.packages = (with pkgs; [
    ponyc
    pony-stable
  ]);
}
