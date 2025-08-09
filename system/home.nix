{
  cfg,
  pkgs,
  ...
}: {
  imports = [
    ../home/git.nix
  ];

  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 24;
    gtk.enable = true;
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
}
