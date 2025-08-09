{cfg, ...}: {
  programs.git = {
    enable = true;
    userName = cfg.displayName;
    userEmail = cfg.email;
  };
}
