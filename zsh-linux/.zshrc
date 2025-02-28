HISTFILE=$HOME/.zsh_history
SAVEHIST=100000
HISTSIZE=99999
setopt auto_cd
setopt share_history
setopt inc_append_history_time
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_verify

# LAZYGIT
export LG_CONFIG_FILE="${HOME}/.config/lazygit/config.yml,${HOME}/.config/lazygit/themes/catppuccin-mocha-blue.yml"

# BAT
export BAT_THEME="Catppuccin Mocha"

# ZSH HISTORY
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# STARSHIP
eval "$(starship init zsh)"

# Antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

# ALIASES
alias ls="eza --icons=always --group-directories-first"
alias la="ls -la"
alias ll="ls -l"
alias lg="ls -la --git"
alias lt="ls -T --git-ignore"
alias utor='aria2c --seed-time=0'

# FZF
source <(fzf --zsh)

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

