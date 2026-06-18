{ config, ... }:

{
  xdg.configFile."nvim-lazy".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/dotfiles/available/lazyvim/dot-config/nvim-lazy";
}
