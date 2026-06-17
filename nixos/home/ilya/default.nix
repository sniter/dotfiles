{ config, pkgs, ... }:

{
  home.username = "ilya";
  home.homeDirectory = "/home/ilya";

  home.stateVersion = "26.05";

  imports = [
    ./packages/cli.nix
    ./packages/dev.nix
    ./packages/media.nix
    ./packages/desktop.nix

    ./programs/git.nix
    ./programs/zsh.nix
  ];
}
