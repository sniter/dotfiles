{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Riga";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb.layout = "us";

  services.printing.enable = true;

  programs.firefox.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.blex-mono
  ];

  # kpmcore's KAuth helper needs to be installed system-wide so its polkit
  # action is registered; installing via home.packages leaves partition
  # actions silently failing.
  environment.systemPackages = with pkgs; [
    kdePackages.partitionmanager
  ];

  nixpkgs.config.allowUnfree = true;

  users.users.ilya = {
    isNormalUser = true;
    home = "/home/ilya";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  allowUnfree = true;

  system.stateVersion = "26.05";
}
