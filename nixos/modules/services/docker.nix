{ ... }:

{
  virtualisation.docker = {
    enable = true;
  };
  users.users.ilya.extraGroups = [ "docker" ];
}
