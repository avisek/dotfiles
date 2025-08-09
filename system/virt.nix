{
  lib,
  pkgs,
  ...
}: {
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["avisek"];
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [virtiofsd];
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

  programs.dconf = {
    enable = true;
    profiles.user.databases = with lib.gvariant; [
      {
        lockAll = true;
        settings = {
          "org/virt-manager/virt-manager" = {
            xmleditor-enabled = true;
          };
          "org/virt-manager/virt-manager/confirm" = {
            delete-storage = false;
          };
          "org/virt-manager/virt-manager/console" = {
            resize-guest = mkInt32 1;
            scaling = mkInt32 0;
          };
          "org/virt-manager/virt-manager/stats" = {
            enable-memory-poll = true;
            enable-disk-poll = true;
            enable-net-poll = true;
          };
          "org/virt-manager/virt-manager/vmlist-fields" = {
            host-cpu-usage = true;
            memory-usage = true;
            disk-usage = true;
            network-traffic = true;
          };
        };
      }
    ];
  };
}
