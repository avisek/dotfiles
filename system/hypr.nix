{
  cfg,
  lib,
  pkgs,
  ...
}: {
  services.getty.autologinUser = cfg.user;
  environment.loginShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ] && uwsm check may-start; then
      exec uwsm start hyprland-uwsm.desktop
    fi
  '';

  programs.hyprland.withUWSM = true;
  programs.hyprland.enable = true;

  # programs.kdeconnect.enable = true;

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    # morewaita-icon-theme
    # adwaita-icon-theme
    # qogir-icon-theme
    # loupe
    # nautilus
    # baobab
    # gnome-text-editor
    # gnome-calendar
    # gnome-boxes
    # gnome-system-monitor
    # gnome-control-center
    # gnome-weather
    # gnome-calculator
    # gnome-clocks
    # gnome-software # for flatpak
    # wl-clipboard
    # wl-gammactl

    kitty
    wofi
    waybar
    hyprpaper
    dunst
    libnotify
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.dconf = {
    enable = true;
    profiles.user.databases = with lib.gvariant; [
      {
        lockAll = true;
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            gtk-theme = "Adwaita";
            icon-theme = "Flat-Remix-Red-Dark";
            font-name = "Noto Sans Medium 9";
            document-font-name = "Noto Sans Medium 9";
            monospace-font-name = "Noto Sans Mono Medium 9";
          };
        };
      }
    ];
  };

  # systemd.user.services.polkit-gnome-authentication-agent-1 = {
  #   description = "polkit-gnome-authentication-agent-1";
  #   wantedBy = ["graphical-session.target"];
  #   wants = ["graphical-session.target"];
  #   after = ["graphical-session.target"];
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #     Restart = "on-failure";
  #     RestartSec = 1;
  #     TimeoutStopSec = 10;
  #   };
  # };

  services = {
    gvfs.enable = true;
    # devmon.enable = true;
    # udisks2.enable = true;
    # upower.enable = true;
    # power-profiles-daemon.enable = true;
    # accounts-daemon.enable = true;
    # gnome = {
    #   evolution-data-server.enable = true;
    #   glib-networking.enable = true;
    #   gnome-keyring.enable = true;
    #   gnome-online-accounts.enable = true;
    #   localsearch.enable = true;
    #   tinysparql.enable = true;
    # };
  };
}
