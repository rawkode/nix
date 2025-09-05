# Development profile relocated
{ inputs, ... }:
{
  flake.nixosModules.profiles-development =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.self.nixosModules.documentation
        inputs.self.nixosModules.ai
        inputs.self.nixosModules.android
      ];

      environment.systemPackages = with pkgs; [
        git
        gh
        vim
        neovim
        gnumake
        gcc
        cmake
        pkg-config
        gdb
        strace
        ltrace
        nmap
        tcpdump
        wireshark
        docker-compose
        podman-compose
      ];

      boot.kernel.sysctl = {
        "fs.inotify.max_user_watches" = 524288;
        "fs.inotify.max_user_instances" = 1024;
      };
    };
}
