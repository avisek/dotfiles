{
  cfg,
  inputs,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./system.nix
    ./maccel.nix
    ./audio.nix
    ./nvidia.nix
    ./sh.nix
    ./virt.nix
    ./hypr.nix
    # ./nautilus.nix
  ];

  users.users.${cfg.user} = {
    isNormalUser = true;
    description = cfg.displayName;
    initialPassword = cfg.user;
    extraGroups = ["wheel"];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit cfg inputs;};
    users.${cfg.user} = {
      home.username = cfg.user;
      home.homeDirectory = "/home/${cfg.user}";
      imports = [./home.nix];
    };
  };
}
