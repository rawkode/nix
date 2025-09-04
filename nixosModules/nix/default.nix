{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.rawkOS.user;
in
{
  imports = [ ../stylix ];

  environment.systemPackages = with pkgs; [
    nix-forecast
    nixd
    nixfmt-rfc-style
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
  };

  nix = {
    optimise.automatic = true;
    gc.automatic = false; # Disabled in favor of programs.nh.clean

    settings = {
      trusted-users = [ cfg.username ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      keep-derivations = true;
      keep-outputs = true;

      substituters = [
        "https://cosmic.cachix.org/"
        "https://nix-community.cachix.org"
        "https://ghostty.cachix.org/"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      ];
    };
  };
}
