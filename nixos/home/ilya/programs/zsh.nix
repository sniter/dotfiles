{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autosuggestion and syntaxHighlighting are loaded by antidote plugins

    history = {
      size = 100000;
      save = 100000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    sessionVariables = {
      EDITOR = "nvim";
      GIT_EDITOR = "vim";
    };

    shellAliases = {
      # modern CLI replacements not covered by dot-zshrc.d/aliases.zsh
      cat = "bat";
      grep = "rg";
      # git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
    };

    # P10k instant prompt must be at the very top of .zshrc
    initExtraFirst = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    initExtra = ''
      # Load antidote; bundle to a writable cache (Nix store is read-only)
      source ${pkgs.antidote}/share/antidote/antidote.zsh
      _ad_src=${../../../../available/zsh-antidote/dot-zsh_plugins.txt}
      _ad_cache="''${XDG_CACHE_HOME:-$HOME/.cache}/antidote/zsh_plugins.zsh"
      if [[ ! -f "$_ad_cache" || "$_ad_src" -nt "$_ad_cache" ]]; then
        mkdir -p "''${_ad_cache:h}"
        antidote bundle <"$_ad_src" >"$_ad_cache"
      fi
      source "$_ad_cache"
      unset _ad_src _ad_cache

      # Source zshrc.d snippets; skip tilde-prefixed (disabled) files
      for _rc in ${../../../../available/zsh-commons/dot-zshrc.d}/*.zsh; do
        [[ $_rc:t != '~'* ]] && source "$_rc"
      done
      unset _rc

      # Load Powerlevel10k theme config
      [[ ! -f ${../../../../available/zsh-commons/dot-p10k.zsh} ]] || source ${../../../../available/zsh-commons/dot-p10k.zsh}
    '';
  };
}
