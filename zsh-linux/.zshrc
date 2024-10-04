#
# HISTORY  
#
HISTFILE=$HOME/.zsh_history
SAVEHIST=100000
HISTSIZE=99999
setopt auto_cd
setopt share_history
setopt inc_append_history_time
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
#
# ALIASES
#
source <(fzf --zsh)
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

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

source ~/.local/share/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

alias ls="eza --icons=always --group-directories-first"
alias la="ls -la"
alias ll="ls -l"
alias lg="ls -la --git"
alias lt="ls -T --git-ignore"
alias ..="cd .."
#
# STARSHIP
#
eval "$(starship init zsh)"

#
# BAT
#
export BAT_THEME="Catppuccin Mocha"

#
# GIT
#
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

function git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done

  # If no main branch was found, fall back to master but return error
  echo master
  return 1
}

function ggp() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}"
  fi
}

function ggf() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force origin "${b:=$1}"
}

alias    ga="git add"
alias   gaa="git add -A"
alias    gb='git branch'
alias   gba='git branch --all'
alias   gbd='git branch --delete'
alias   gbD='git branch --delete --force'
alias  gca!='git commit --verbose --all --amend'
alias  gcam='git commit --all --message'
alias   gco='git checkout'
alias   gcb='git checkout -b'
alias   gcB='git checkout -B'
alias   gcp='git cherry-pick'
alias  gcpa='git cherry-pick --abort'
alias  gcpc='git cherry-pick --continue'
alias    gf='git fetch'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias    gm='git merge'
alias   gma='git merge --abort'
alias   gmc='git merge --continue'
alias   gms="git merge --squash"
alias  gmnf="git merge --no-ff"
alias  gmom="gmnf origin/$(git_main_branch)"
alias    gp='git push'
alias  gprv='git pull --rebase -v'
alias   grv='git remote --verbose'
alias   gra='git remote add'
alias  grrm='git remote remove'
alias  grmv='git remote rename'
alias   gss="git status -s"
alias   gst="git status"
alias gstal='git stash --all'
alias gstaa='git stash apply'
alias  gstc='git stash clear'
alias  gstd='git stash drop'
alias  gstl='git stash list'
alias  gstp='git stash pop'
alias  gsta='git stash push'
alias  grba='git rebase --abort'
alias  grbc='git rebase --continue'
alias grbom='git rebase origin/$(git_main_branch)'

#
# ZSH 
#
export EDITOR=nvim
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
source ~/.local/share/zsh-autosuggestions/zsh-autosuggestions.zsh


# BAT
export BAT_THEME="Coldark-Dark"

#
# Aliases
# 
alias utor='aria2c --seed-time=0'

#
# Haskell
#
[ -f "/Users/ilya/.ghcup/env" ] && source "/Users/ilya/.ghcup/env" # ghcup-env

#
# Ocaml/Opam
#
[[ ! -r /Users/ilya/.opam/opam-init/init.zsh ]] || source /Users/ilya/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# JDK from ports
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-21-oracle-openjdk.jdk/Contents/Home

