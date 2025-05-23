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
    btop.enable = true;
    eza = {
      enable = true;
      icons = "auto";
    };
    fd.enable = true;
    fzf = {
      enable = true;
      defaultCommand = "";
    };
    git = {
      enable = true;
      userName = "Ilya Babich";
      userEmail = "sniter@gmail.com";
    };
    htop.enable = true;
    jq.enable = true;
    lazygit = {
      enable = true;
      # TODO: add theme
    };
    less.enable = true;
    oh-my-posh = {
      enable = true;
      useTheme = "catppuccin_frappe";
    };
    ripgrep.enable = true;
    tmux = {
      enable = true;
      # TODO: Configure
      shell = "${pkgs.zsh}/bin/zsh";
      extraConfig = ''
        bind -n M-0  select-window -t 0
        bind -n M-1 select-window -t 1
        bind -n M-2 select-window -t 2
        bind -n M-3 select-window -t 3
        bind -n M-4 select-window -t 4
        bind -n M-5 select-window -t 5
        bind -n M-6 select-window -t 6
        bind -n M-7 select-window -t 7
        bind -n M-8 select-window -t 8
        bind -n M-9 select-window -t 9
        bind -n M-c new-window
        bind -n M-. command-prompt -T target { move-window -b -t "%%" } \; move-window -r
        bind -n M-, command-prompt -I "#W" { rename-window "%%" }
        bind -n M-d detach-client
        bind -n M-Q kill-server
        bind -n M-h split-window -v
        bind -n M-v split-window -h
        # Simple navigation between panes
        bind -n M-Left  select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up    select-pane -U
        bind -n M-Down  select-pane -D
        # select-window
        bind -n M-w choose-tree -Zw
        bind -n M-s choose-tree -Zs -O name
        bind -n M-z resize-pane -Z
        bind -n M-l clear-history
      '';
      plugins = with pkgs; [
        tmuxPlugins.cpu
        {
          plugin = tmuxPlugins.resurrect;
          # extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        # TODO: missing tmux-plugins/tmux-which-key
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor 'frappe'
            set -g @catppuccin_window_status_style 'basic'
            set -g status-left ""
            set -g status-right "#{E:@catppuccin_status_application}"
            # set -agF status-right "#{E:@catppuccin_status_cpu}"
            set -ag status-right "#{E:@catppuccin_status_session}"
            set -ogq @catppuccin_window_text " #W"
            set -ogq @catppuccin_window_current_text " #W"
            # set -ag status-right "#{E:@catppuccin_status_uptime}"
            # set -agF status-right "#{E:@catppuccin_status_battery}"
          '';
        }
        # {
        #   plugin = tmuxPlugins.continuum;
        #   extraConfig = ''
        #     set -g @continuum-restore 'on'
        #     set -g @continuum-save-interval '60' # minutes
        #   '';
        # }
      ];
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
    ghostty
    stow
    tmux zellij
    openssh
    jdk21_headless coursier
    ibm-plex
    gnumake gcc
    gzdoom
    unzip

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
