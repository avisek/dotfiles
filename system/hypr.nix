{
  lib,
  pkgs,
  ...
}: {
  services.getty.autologinUser = "avisek";
  environment.loginShellInit = ''
    if uwsm check may-start; then
      exec uwsm start hyprland-uwsm.desktop
    fi
  '';

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
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

  services.gvfs.enable = true;
}
