{ config, pkgs, ... }:

with pkgs;
{
  home.packages = (with pkgs; [
    pipenv
    python
    pythonPackages.virtualenv
  ]);
}
