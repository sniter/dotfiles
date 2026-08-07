{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty ghostty
    brave tor-browser
    anki-bin
    bluetui
    obsidian
  ];
}
