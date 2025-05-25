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

