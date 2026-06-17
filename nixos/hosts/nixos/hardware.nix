{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-d8fad603-16e6-4f26-841c-8f383b06e940".device =
    "/dev/disk/by-uuid/d8fad603-16e6-4f26-841c-8f383b06e940";
}
