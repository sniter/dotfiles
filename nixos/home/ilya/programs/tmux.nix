{ config, ... }:

{
  xdg.configFile."tmux".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/available/tmux/dot-config/tmux";
}
