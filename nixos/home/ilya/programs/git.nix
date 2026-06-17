{ ... }:

{
  programs.git.enable = true;

  programs.git.settings = {

    user = {
    	name = "Ilya Babich";
        email = "sniter@gmail.com";
    };

    init.defaultBranch = "main";
    pull.rebase = true;
    rebase.autoStash = true;
    core.editor = "nvim";
    diff.colorMoved = "default";
    merge.conflictstyle = "diff3";

    alias = {
      st = "status";
      co = "checkout";
      br = "branch";
      cm = "commit";
      lg = "log --oneline --graph --decorate --all";
    };
  };
}
