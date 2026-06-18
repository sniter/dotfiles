{ config, ... }:

{
  home.file.".ssh/config" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/available/ssh/dot-ssh/config";
  };
}
