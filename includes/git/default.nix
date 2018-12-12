{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName  = "David McKay";
    userEmail = "rawkode@pm.me";
  };

}
