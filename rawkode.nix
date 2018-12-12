{ config, pkgs, ... }:

let
  isDir = path: builtins.pathExists (path + "/.");

  include = path:
    if isDir path
    then
      let
        content = builtins.readDir path;
      in
        map (n: import (path + ("/" + n)))
            (builtins.filter (n: builtins.match ".*\\.nix" n != null || builtins.pathExists (path + ("/" + n + "/default.nix")))
                    (builtins.attrNames content))
    else
    import path;
in {
  nixpkgs.config = {
    allowUnfree = true;
  };

  fonts.fontconfig = {
    enableProfileFonts = true;
  };

  home.packages = (with pkgs; [
    gnumake
    lxappearance
    vim
  ] ++ [
    # Communication
    slack
    wavebox
  ]);

  imports = include ./includes;
}

