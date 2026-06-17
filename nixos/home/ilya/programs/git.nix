{ ... }:

{
  programs.git = {
    enable = true;

    userName = "Ilya Babich";
    userEmail = "sniter@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";

      pull.rebase = true;
      rebase.autoStash = true;

      core.editor = "nvim";

      diff.colorMoved = "default";

      merge.conflictstyle = "diff3";
    };

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      cm = "commit";
      lg = "log --oneline --graph --decorate --all";
    };
  };
}
