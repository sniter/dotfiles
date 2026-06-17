# dev.nix
{
  home.packages = with pkgs; [
    git lazygit
    python3
    jdk21_headless
    gcc gnumake
    cargo
    coursier
  ];
}
