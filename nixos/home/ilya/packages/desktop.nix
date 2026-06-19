{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty ghostty
    brave
    anki-bin
    bluetui
    obsidian
  ];
}
