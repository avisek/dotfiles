{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellInit = ''
      zsh-newuser-install() { :; }
    '';
  };

  users.defaultUserShell = pkgs.zsh;

  environment.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/nixos --impure";
    nrt = "sudo nixos-rebuild test --flake ~/nixos --impure";
    nrb = "sudo nixos-rebuild boot --flake ~/nixos --impure";
    nrbr = "nrb && reboot";
    nfu = "nix flake update --flake ~/nixos --impure";
    ngc = "sudo nix-collect-garbage -d && nrb";
    ngcr = "ngc && reboot";
  };
}
