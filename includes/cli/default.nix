{ config, pkgs, ... }:

{
  home.file.".zshrc".source = ./zsh/zshrc.zsh;
  home.file.".zsh/aliases.zsh".source = ./zsh/aliases.zsh;
  home.file.".zsh/common.zsh".source = ./zsh/common.zsh;
  home.file.".zsh/history.zsh".source = ./zsh/history.zsh;
  home.file.".zsh/keybindings.zsh".source = ./zsh/keybindings.zsh;
  home.file.".zsh/paths.zsh".source = ./zsh/paths.zsh;
  home.file.".zsh/powerlevel9k.zsh".source = ./zsh/powerlevel9k.zsh;
  home.file.".zsh/zplug.zsh".source = ./zsh/zplug.zsh;

  home.file.".config/fish/config.fish".source = ./fish/config.fish;
  home.file.".config/fish/fishfile".source = ./fish/fishfile;

  home.packages = (with pkgs; [
    direnv
    exa
    fzf
    ripgrep
    tldr
    unzip
    vim
    wget
    zsh
  ]);

  programs.autorandr.enable = true;
  programs.direnv.enable = true;
}
