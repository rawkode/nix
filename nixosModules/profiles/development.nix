# Development profile - tools and settings for developers
{ config, lib, pkgs, ... }:
{
  imports = [
    # ../containers  # Now in base profile
    ../documentation
    ../ai # AI/LLM tools and Qdrant vector database
    ../android # Android development tools and ADB
  ];

  # Development tools
  environment.systemPackages = with pkgs; [
    # Version control
    git
    gh

    # Editors
    vim
    neovim

    # Build tools
    gnumake
    gcc
    cmake
    pkg-config

    # Debugging
    gdb
    strace
    ltrace

    # Network tools
    nmap
    tcpdump
    wireshark

    # Container tools
    docker-compose
    podman-compose
  ];

  # Docker and Podman configuration moved to containers module in base profile

  # Development-friendly kernel parameters
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
    "fs.inotify.max_user_instances" = 1024;
  };
}
