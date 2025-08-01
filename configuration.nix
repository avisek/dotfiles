# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  services.libinput = {
    # Enable touchpad support (enabled default in most desktopManager).
    enable = true;

    # https://wiki.nixos.org/wiki/Xorg#Disabling_touchpad_and_mouse_accelerations
    mouse = {
      # Disable mouse acceleration
      accelProfile = "flat";
    };
    touchpad = {
      # Disable touchpad acceleration
      accelProfile = "flat";
    };
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  # https://nixos.wiki/wiki/PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # https://mynixos.com/nixpkgs/option/services.pipewire.wireplumber.extraConfig
    # https://wiki.archlinux.org/title/WirePlumber
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

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable Nvidia proprietary drivers.
  # https://wiki.nixos.org/wiki/NVIDIA
  # https://nixos.wiki/wiki/nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;

  # # Dead simple TTY-based auto-login setup for Hyprland
  # services.xserver.displayManager.lightdm.enable = false; # Disable default display manager (ensure no other DMs are enabled)
  # services.getty.autologinUser = "avisek"; # Auto-login user on boot
  # environment.loginShellInit = ''
  #   # Launch Hyprland on TTY1, return to TTY when exiting
  #   if [ "$(tty)" = "/dev/tty1" ]; then
  #     Hyprland # Use `exec Hyprland` to auto-restart on exit/crash instead
  #   fi
  # '';

  # TTY-based UWSM-managed auto-login setup for Hyprland
  services.xserver.displayManager.lightdm.enable = false; # Disable default display manager
  services.getty.autologinUser = "avisek"; # Auto-login user on boot
  environment.loginShellInit = ''
    # https://wiki.hypr.land/Useful-Utilities/Systemd-start/#in-tty
    if uwsm check may-start; then
      exec uwsm start hyprland-uwsm.desktop
    fi
  '';

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable Hyprland.
  # https://wiki.nixos.org/wiki/Hyprland#Installation
  # https://wiki.hypr.land/Nix/Hyprland-on-NixOS
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # https://wiki.nixos.org/wiki/GNOME#dconf
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = true; # prevents overriding
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

  # Enable GVfs for better file system integration with GTK apps.
  # https://nixos.wiki/wiki/Nautilus#GVfs
  services.gvfs.enable = true;

  # https://nixos.wiki/wiki/Zsh#Example_Configuration
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellInit = ''
      # Disable zsh's newuser startup script that prompts you to create
      # a ~/.z* file if missing
      # https://unix.stackexchange.com/a/57926
      zsh-newuser-install() { :; }
    '';
  };
  # https://nixos.wiki/wiki/Command_Shell
  users.defaultUserShell = pkgs.zsh;

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  networking.firewall.trustedInterfaces = ["virbr0"];
  systemd.services.libvirt-default-network = {
    description = "Start libvirt default network";
    after = ["libvirtd.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.libvirt}/bin/virsh net-start default";
      ExecStop = "${pkgs.libvirt}/bin/virsh net-destroy default";
      User = "root";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.avisek = {
    isNormalUser = true;
    description = "Avisek Das";
    extraGroups = [
      "networkmanager"
      "wheel" # Enable ‘sudo’ for the user.
      "libvirtd"
    ];
    packages = with pkgs; [
      # tree
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    tree
    bat
    gedit
    kitty
    wofi
    waybar
    hyprpaper
    dunst
    libnotify
    google-chrome
    vscode-fhs
    code-cursor

    nixfmt-rfc-style # Official formatter for Nix language code
    alejandra # Alternative formatter with improved readability

    pfetch-rs
    fastfetch
    btop-cuda # System monitor - with Nvidia GPU support
    # btop-rocm # System monitor - with AMD GPU support
    cmatrix # Terminal animation
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/nixos";
    nrb = "sudo nixos-rebuild boot --flake ~/nixos";
    nrbr = "nrb && reboot";
    nfu = "nix flake update --flake ~/nixos";
    ngc = "sudo nix-collect-garbage -d && nrb";
    ngcr = "ngc && reboot";
  };
}
