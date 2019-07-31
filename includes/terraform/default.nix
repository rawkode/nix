{ config, pkgs, ... }:

with pkgs;
{
  home.packages = (with pkgs; [
    terraform_0_12
  ]);
}
