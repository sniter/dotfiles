{ config, pkgs, fonts, ... }:


{
  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ilya";
  home.homeDirectory = "/home/ilya";

  programs = {
    alacritty = {
      enable = true;
      settings = {
        general.import = ["themes/catppuccin-frappe.toml"];
        font = {
          normal.family = "BlexMono Nerd Font Mono";
          bold.family = "BlexMono Nerd Font Mono";
          italic.family = "BlexMono Nerd Font Mono";
          bold_italic.family = "BlexMono Nerd Font Mono";
          size = 13;
        };
        keyboard = {
          bindings = [
            {key = "k"; mods = "Super"; mode = "~Vi|~Search"; chars = "\u000c";}
            {key = "k"; mods = "Super"; mode = "~Vi|~Search"; action = "ClearHistory";}
            {key = "Escape"; mods = "Control|Shift"; action="ToggleViMode";}
            # {key = "Escape"; mods = "Control|Shift"; mode = ""; action="ToggleViMode";}
          ];
        };
        window = {
          padding.x = 5;
          padding.y = 5;
          decorations = "Buttonless";
          opacity = 0.9;
          blur = true;
          option_as_alt = "Both";
          startup_mode = "Maximized";
        };
        env = {
          TERM = "xterm-256color";
        };
      };
    };
    aria2.enable = true;
    bat = {
      enable = true;
      themes = {
        catppuccin = {
          src = builtins.fetchGit {
            url = "https://github.com/catppuccin/bat.git";
            rev = "699f60fc8ec434574ca7451b444b880430319941";
          };
        };
      };
      config.theme = "Catppuccin Frappe";
    };
    git = {
      enable = true;
      userName = "Ilya Babich";
      userEmail = "sniter@gmail.com";
    };
    zsh = {
      enable = true;
      autocd = true;
      autosuggestion = {
        enable = true;
        highlight = "fg=#ff00ff,bg=#303446";
      };
      antidote = {
        enable = true;
        plugins = [
          "getantidote/use-omz"
          "ohmyzsh/ohmyzsh path:lib"
          "ohmyzsh/ohmyzsh path:plugins/git"
          # "romkatv/powerlevel10k"
          "junegunn/fzf-git.sh"
        ];
      };
    };
    eza = {
      enable = true;
      icons = "auto";
    };
    fd.enable = true;
    fzf = {
      enable = true;
      defaultCommand = "";
    };
    oh-my-posh = {
      enable = true;
      useTheme = "catppuccin_frappe";
    };
  };
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # hello
    ghostty
    jq htop less ripgrep stow
    tmux zellij
    lazygit
    openssh
    jdk21_headless coursier
    ibm-plex
    gnumake gcc
    gzdoom

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (nerdfonts.override { fonts = [ "IBMPlexMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # fonts.packages = with pkgs; [ nerdfonts ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Preserve backward compatibility with Stow
    "/home/ilya/.config/eza/themes/default.yml".source = eza/themes/catppuccin.yml;
    "/home/ilya/.config/alacritty/themes" = {
      source = builtins.fetchGit {
        url = "https://github.com/catppuccin/alacritty.git";
        rev = "f6cb5a5c2b404cdaceaff193b9c52317f62c62f7";
      };
    };
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ilya/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
