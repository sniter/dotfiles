# cli.nix
{
  home.packages = with pkgs; [
    bat less jq
    eza fd fzf ripgrep zoxide yazi
    btop htop atop
    tmux zellij sesh
    unzip wget aria2
  ];
}
