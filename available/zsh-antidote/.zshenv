#!/bin/zsh
#
# Set ZDOTDIR if you want to re-home Zsh.
# export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
# export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
# export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
# export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

# Set the list of directories that zsh searches for commands.
path=(
  $HOME/{,s}bin(N)
  $HOME/.local/{,s}bin(N)
  $HOME/.local/share/coursier/bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# Settings editor
export EDITOR=nvim
export GIT_EDITOR=vim

# NixOS session vars
# . "/home/ilya/.nix-profile/etc/profile.d/hm-session-vars.sh"
# Only source this once
# if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]; then
#   export __HM_ZSH_SESS_VARS_SOURCED=1
# fi
