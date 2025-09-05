{ inputs, ... }:
{
  flake.homeModules.development =
    # Development tools and environments
    {
      inputs,
      config,
      lib,
      pkgs,
      ...
    }:

    {
      imports = with inputs.self.homeModules; [
        development-bun
        development-dagger
        development-deno
        development-devenv
        development-distrobox
        development-docker
        development-flox
        development-go
        development-kubernetes
        development-moon
        development-nix
        development-podman
        development-python
        development-rust
      ];
    };
}
