{ config, pkgs, ... }:

{
  # home.file = {
  #   ".zshrc".source =
  #     config.lib.file.mkOutOfStoreSymlink
  #       "${config.home.homeDirectory}/dotfiles/.zshrc";
  #
  #   ".zshenv".source =
  #     config.lib.file.mkOutOfStoreSymlink
  #       "${config.home.homeDirectory}/dotfiles/.zshenv";
  # };

  xdg.configFile = {
    "nvim-lazy".source = ../../../../../available/lazyvim/dot-config/nvim-lazy
      # config.lib.file.mkOutOfStoreSymlink
      #   "${config.home.homeDirectory}/dotfiles/lazyvim";

  #   "git".source =
  #     config.lib.file.mkOutOfStoreSymlink
  #       "${config.home.homeDirectory}/dotfiles/git";
  # };
}
