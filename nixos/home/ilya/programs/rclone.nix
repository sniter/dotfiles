{ pkgs, ... }:

let
  mkBisyncService = localDir: remoteDir: {
    Unit = {
      Description = "Two-way sync ${localDir} with onedrive:${remoteDir}";
      After = "network-online.target";
      Wants = "network-online.target";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.rclone}/bin/rclone bisync ${localDir} onedrive:${remoteDir} --create-empty-src-dirs --resilient -v";
    };
  };

  mkBisyncTimer = {
    Timer = {
      OnBootSec = "5min";
      OnUnitActiveSec = "1h";
    };
    Install.WantedBy = [ "timers.target" ];
  };
in
{
  systemd.user.services = {
    rclone-bisync-music    = mkBisyncService "%h/Music"    "Music";
    rclone-bisync-pictures = mkBisyncService "%h/Pictures" "Pictures";
  };

  systemd.user.timers = {
    rclone-bisync-music    = mkBisyncTimer;
    rclone-bisync-pictures = mkBisyncTimer;
  };
}
