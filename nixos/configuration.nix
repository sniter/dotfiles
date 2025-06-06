# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  hardware.bluetooth.enable = true;

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
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ilya = {
    isNormalUser = true;
    description = "Ilya Babich";
    extraGroups = [ "networkmanager" "wheel"];
    packages = with pkgs; [
      kdePackages.kate
    ];
    #  thunderbird
    shell = pkgs.zsh;
  };
  home-manager = {
    backupFileExtension = "bak.nix";
    users.ilya = {
      programs.alacritty.enable = true;
      programs.ghostty.enable = true;
      # programs.zsh.enable = true;
      home.packages = with pkgs; [
        bitwarden
        git lazygit
        alacritty ghostty
        aria2 posting wget openssh
        bat less jq
        eza fd fzf ripgrep zoxide 
        atop btop htop
        tmux zellij sesh
        stow unzip
        gzdoom 
        ibm-plex
        python3 jdk21_headless coursier nodejs cargo gnumake gcc
        # Neovim
        tree-sitter wl-clipboard 
        luajit luajitPackages.sqlite luajitPackages.luasql-sqlite3 luajitPackages.luarocks
        sqlite 
        imagemagick
        tectonic
        mermaid-cli
        ghostscript
        # Multimedia
        picard yt-dlp kew
      ];  
      home.sessionVariables = {
        # Fix the libsqlite.so not found issue for https://github.com/kkharji/sqlite.lua.
        LD_LIBRARY_PATH =
        "${pkgs.lib.makeLibraryPath (with pkgs; [ sqlite ])}:$LD_LIBRARY_PATH";
      };
      home.stateVersion = "25.05";
    };
  };
  
  
  # Install firefox.
  programs.firefox.enable   = true;
  programs.zsh.enable       = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    lua-language-server
  ];
  # Install neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Install firefox.
  #programs.firefox.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.blex-mono
  ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
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
