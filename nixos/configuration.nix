# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Riga";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # KDE
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.flatpak.enable = true;  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.ilya = {
    isNormalUser = true;
    description = "ilya";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
        vim neovim helix
        zsh git lazygit
        alacritty ghostty kitty
        aria2 wget openssh
        bat less jq
        eza fd fzf ripgrep zoxide yazi 
        atop btop htop
        tmux zellij sesh
        stow unzip
        gzdoom 
        python3 jdk21_headless coursier cargo gnumake gcc
        # Neovim
        tree-sitter wl-clipboard 
        luajit luajitPackages.luarocks
        # Multimedia
        yt-dlp ffmpeg-full atomicparsley mutagen
        kew
        # Others
        bitwarden
        # gnome-tweaks whitesur-cursors
        anki-bin
    ];
    shell = pkgs.zsh;
  };

  # Install ZSH
  programs.zsh.enable = true;

  # Install font
  fonts.packages = with pkgs; [
    nerd-fonts.blex-mono
  ];

  # Install neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # GNOME SETTINGS
  # programs.dconf.profiles.user.databases = [
  #   {
  #     lockAll = true; # prevents overriding
  #     settings = {
  #       "org/gnome/desktop/input-sources" = {
  #         xkb-options = [ "grp:caps_toggle" "terminate:ctrl_alt_bksp" ];
  #       };
  #       "org/gnome/desktop/interface" = {
  #         color-scheme = "prefer-dark";
  #       };
  #     };
  #   }
  # ];
  
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  wget curl less vim neovim helix
  # KDE
  kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
  kdePackages.kcalc # Calculator
  kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
  kdePackages.kclock # Clock app
  kdePackages.kcolorchooser # A small utility to select a color
  kdePackages.kolourpaint # Easy-to-use paint program
  kdePackages.ksystemlog # KDE SystemLog Application
  kdePackages.sddm-kcm # Configuration module for SDDM
  kdiff3 # Compares and merges 2 or 3 files or directories
  kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
  kdePackages.partitionmanager # Optional: Manage the disk devices, partitions and file systems on your computer
  # Non-KDE graphical packages
  hardinfo2 # System information and benchmarks for Linux systems
  vlc # Cross-platform media player and streaming server
  wayland-utils # Wayland utilities
  wl-clipboard # Command-line copy/paste utilities for Wayland
  xclip # Tool to access the X clipboard from a console application
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
