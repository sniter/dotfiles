{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Ilya Babich";
        email = "sniter@gmail.com";
      };

      init.defaultBranch = "main";

      core = {
        autocrlf = "input";
        pager = "less -S";
        editor = "nvim";
      };

      push.default = "matching";
      pull.rebase = true;
      rebase.autoStash = true;

      diff = {
        algorithm = "patience";
        compactionHeuristic = true;
        colorMoved = "default";
        tool = "nvimdiff";
      };

      merge = {
        tool = "nvimdiff4";
        prompt = false;
        conflictstyle = "diff3";
      };

      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        interactive = "auto";
        ui = true;
        pager = true;
      };

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        cm = "commit";
        lg  = "!git lg1";
        lg1 = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
        lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
        lg3 = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
        commit-merge = "!head -1 $(git rev-parse --git-dir)/MERGE_MSG | git commit -F -";
      };

      difftool.nvimdiff.cmd = ''nvim -d "$LOCAL" "$REMOTE" -c "wincmd w" -c "wincmd L"'';

      mergetool.nvimdiff4.cmd = "nvim -d $LOCAL $BASE $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
    };
  };
}
