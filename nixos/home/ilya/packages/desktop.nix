{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty ghostty
    brave 
    tor-browser librewolf
    anki-bin
    bluetui
    obsidian
  ];
}
