# dev.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git lazygit
    python3
    jdk21_headless
    gcc gnumake
    tree-sitter
    cargo
    coursier
  ];
}
