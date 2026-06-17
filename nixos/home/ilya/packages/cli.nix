# cli.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat less jq
    eza fd fzf ripgrep zoxide yazi
    btop htop atop
    tmux zellij sesh rclone
    vim neovim helix
    unzip wget aria2
  ];
}
