{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName  = "David McKay";
    userEmail = "rawkode@pm.me";

    signing = {
      key = "2D8641614CBEDB36443A1F1C4E81F61612CDF165";
      signByDefault = true;
    };

    aliases = {
      ps = "push";
    };
  };

}
