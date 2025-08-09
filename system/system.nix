{
  cfg,
  pkgs,
  ...
}: {
  # nix
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
    warn-dirty = false;
  };
  nixpkgs.config.allowUnfree = true;

  # packages
  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    tree
    bat
    google-chrome
    vscode-fhs
    code-cursor
    alejandra
    pfetch-rs
    fastfetch
    btop-cuda
    cmatrix
  ];

  # services
  services = {
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
      displayManager.lightdm.enable = false;
    };
    # sysprof.enable = true;
    # printing.enable = true;
    # flatpak.enable = true;
    # openssh.enable = true;
  };

  # network
  networking.networkmanager.enable = true;
  users.groups.networkmanager.members = [cfg.user];

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.General.Experimental = true; # bluetooth percentage
  };

  # bootloader
  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = ["ntfs"];
    loader = {
      timeout = 2;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  system.stateVersion = "25.05";
}
