{
  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber.extraConfig = {
      "bluez-monitor.conf" = {
        "properties" = {
          "bluez5.roles" = [ "a2dp_sink" "a2dp_source" "hfp_hf" "hfp_ag" ];
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
        };
      };
    };
  };
}
