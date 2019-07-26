{ config, pkgs, ... }:

with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    virtualenv
  ];
  python37Custom = python37.withPackages my-python-packages;
in
{
  home.packages = (with pkgs; [
    python37Custom
    pipenv
  ]);
}
