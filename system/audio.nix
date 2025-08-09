{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber.extraConfig = {
      "disable-broken-onboard-audio" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {
                "device.name" = "alsa_card.pci-0000_0c_00.4";
              }
            ];
            actions = {
              update-props = {
                "device.disabled" = true;
              };
            };
          }
        ];
      };
    };
  };
}
