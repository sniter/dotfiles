{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 100000;
      save = 100000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    shellAliases = {
      ll = "eza -lah";
      ls = "eza";
      la = "eza -la";

      cat = "bat";
      grep = "rg";

      gs = "git status";
      ga = "git add";
      gc = "git commit";
    };

    # initExtra = ''
    #   export EDITOR=nvim
    #   export VISUAL=nvim
    #
    #   # nicer prompt behavior
    #   setopt PROMPT_SUBST
    #   setopt HIST_IGNORE_ALL_DUPS
    #   setopt AUTO_CD
    # '';
    initExtra = ''
      # antidote
      source ${pkgs.antidote}/share/antidote/antidote.zsh
      antidote load ${../../../../available/zsh-antidote/dot-zsh_plugins.txt}

      if [[ -o interactive ]]; then
        source ${ ../../../../available/zsh-commons/dot-p10k.zsh}
      fi
    '';
  };
}
