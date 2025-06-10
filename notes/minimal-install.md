# Minimal Install

```sh
sudo -i

clear # or Ctrl+L

ping mynixos.com

lsblk

cfdisk /dev/sda

# Select label type -> gpt

# New -> 1G -> Type -> EFI System

# Free space -> New -> ?G -> Type -> Linux filesystem (default)

# Write -> yes -> Quit

clear

lsblk

mkfs.fat -F 32 -n boot /dev/sda1

mkfs.ext4 -L nixos /dev/sda2

lsblk

mount /dev/sda2 /mnt

mkdir -p /mnt/boot

mount -o umask=077 /dev/sda1 /mnt/boot

# Not sure what it does
mount -t efivarfs efivarfs /sys/firmware/efi/efivars

lsblk

nixos-generate-config --root /mnt

nano /mnt/etc/nixos/configuration.nix

# Uncomment and adjust:
networking.hostName = "nixos";
networking.networkmanager.enable = true;
time.timeZone = "Asia/Kolkata";
services.xserver.enable = true;
programs.hyprland.enable = true; # Add
user.users.avisek = { ... };
programs.firefox.enable = true;
environment.systemPackages = with pkgs; [ vim wget neovim gedit alacritty kitty ];
# Save and exit (Ctrl-O -> Enter -> Ctrl-X)

clear

nixos-install

nixos-enter --root /mnt -c 'passwd avisek'

reboot

```
