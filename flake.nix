{
  description = "rawkOS: Rawkode's Nix Configured Operating System";

  inputs = {
    # Core inputs
    flakelight.url = "github:nix-community/flakelight";
    nixpkgs.url = "github:NixOS/nixpkgs/pull/436682/head";
    
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Additional nixpkgs sources
    clickup.url = "github:NixOS/nixpkgs/pull/437226/head";
    cue.url = "github:NixOS/nixpkgs/pull/431813/head";
    v4l2.url = "github:NixOS/nixpkgs/pull/436682/head";
    master.url = "github:nixos/nixpkgs/master";
    
    # Community
    nur.url = "github:nix-community/NUR";
    
    # Tools and applications
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    browser-previews = {
      url = "github:nix-community/browser-previews";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    codex.url = "github:openai/codex/pull/2527/head";
    comma = {
      url = "github:nix-community/comma";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cuenv.url = "github:rawkode/cuenv";
    dagger = {
      url = "github:dagger/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox.url = "github:nix-community/flake-firefox-nightly";
    flatpaks.url = "github:gmodena/nix-flatpak";
    gauntlet = {
      url = "github:project-gauntlet/gauntlet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ai-tools.url = "github:numtide/nix-ai-tools";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
    wezterm.url = "github:wez/wezterm/bc3dde9e75b7f656f32a996378ec6048df2bfda4?dir=nix";
    yazi-flavors = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };
  };

  outputs = inputs@{ self, flakelight, nixpkgs, treefmt-nix, home-manager, ... }:
    flakelight ./. {
      inherit inputs;
      
      # System configurations
      systems = [ "x86_64-linux" ];
      
      # Don't use auto-discovery for nixosConfigurations due to path issues
      # nixDir = ./.;
      
      # Explicitly define nixosConfigurations to handle path correctly
      nixosConfigurations = {
        p4x-framework-nixos = import ./nixos/p4x-framework-nixos.nix;
        p4x-desktop-nixos = import ./nixos/p4x-desktop-nixos.nix;
        p4x-laptop-nixos = import ./nixos/p4x-laptop-nixos.nix;
      };
      
      # Configure nixpkgs
      nixpkgs.config = {
        allowUnfree = true;
        joypixels.acceptLicense = true;
      };

      # Additional overlays beyond auto-discovered ones
      withOverlays = [
        inputs.nur.overlays.default
        (final: prev: {
          v4l-utils = inputs.v4l2.legacyPackages.${prev.system}.v4l-utils;
        })
      ];

      # Per-system configuration
      perSystem = pkgs: {
        # Formatter using treefmt
        formatter = (treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build.wrapper;
        
        # Apps that can be run with 'nix run'
        apps = {
          update = {
            type = "app";
            program = "${pkgs.writeShellScript "update-flake" ''
              echo "Updating flake inputs..."
              nix flake update
              echo "Done!"
            ''}";
          };
          
          clean = {
            type = "app";
            program = "${pkgs.writeShellScript "clean" ''
              echo "Cleaning old generations..."
              nix-collect-garbage -d
              echo "Done!"
            ''}";
          };
        };
      };

      # Development shell additions
      devShell = {
        packages = pkgs: with pkgs; [
          nixpkgs-fmt
          nil
          nix-tree
          nix-diff
          statix
        ];
        
        env = {
          FLAKE_ROOT = "$PWD";
        };
        
        shellHook = ''
          echo "Welcome to rawkOS development shell!"
          echo "Run 'nix flake show' to see available outputs"
        '';
      };
      
      # Home configurations
      homeConfigurations = {
        rawkode = import ./home/rawkode.nix inputs;
      };
      
      # Templates for quick project initialization
      templates = {
        default = {
          path = ./templates/default;
          description = "A basic Nix flake template";
        };
        
        rust = {
          path = ./templates/rust;
          description = "Rust development environment";
        };
      };
      
      # Flakelight modules for reuse
      flakelightModules = {
        rawkOS = ./flakeModules/rawkOS.nix;
      };
      
      # Package bundlers
      bundlers = pkgs: {
        toDockerImage = pkg: pkgs.dockerTools.buildImage {
          name = pkg.pname or "app";
          tag = pkg.version or "latest";
          copyToRoot = pkgs.buildEnv {
            name = "image-root";
            paths = [ pkg ];
          };
        };
      };
      
      # Additional checks beyond formatting
      checks = pkgs: {
        statix = pkgs.runCommand "statix-check" {
          nativeBuildInputs = [ pkgs.statix ];
        } ''
          echo "Running statix checks..."
          ${pkgs.statix}/bin/statix check --ignore result || true
          touch $out
        '';
      };
    };
}