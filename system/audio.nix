{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber.extraConfig = {
      "device-rename" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {
                "node.name" = "alsa_output.pci-0000_0c_00.4.analog-stereo";
              }
            ];
            actions = {
              update-props = {
                "node.description" = "Speakers";
              };
            };
          }
          {
            matches = [
              {
                "node.name" = "alsa_output.pci-0000_0a_00.1.hdmi-stereo";
              }
            ];
            actions = {
              update-props = {
                "node.description" = "HDMI";
              };
            };
          }
          {
            matches = [
              {
                "node.name" = "alsa_output.pci-0000_0c_00.4.iec958-stereo";
              }
            ];
            actions = {
              update-props = {
                "node.description" = "S/PDIF";
                "node.disabled" = true;
              };
            };
          }
        ];
      };
    };
  };
}
