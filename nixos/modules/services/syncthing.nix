{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "ilya";
    dataDir = "/home/ilya";
    openDefaultPorts = true;
  };
}
