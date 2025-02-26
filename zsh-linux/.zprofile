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

# >>> coursier install directory >>>
export PATH="$PATH:/home/ilya/.local/share/coursier/bin"
# <<< coursier install directory <<<

# LAZYGIT
export LG_CONFIG_FILE="${HOME}/.config/lazygit/config.yml,${HOME}/.config/lazygit/themes/catppuccin-mocha-blue.yml"
# BAT
export BAT_THEME="Catppuccin Mocha"

# ZSH 
export EDITOR=nvim
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ALIASES
alias ls="eza --icons=always --group-directories-first"
alias la="ls -la"
alias ll="ls -l"
alias lg="ls -la --git"
alias lt="ls -T --git-ignore"
alias utor='aria2c --seed-time=0'
# alias ..="cd .."

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

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
