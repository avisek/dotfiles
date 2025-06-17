{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "avisek";
  home.homeDirectory = "/home/avisek";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake /home/avisek/nixos";
      nrb = "sudo nixos-rebuild boot --flake /home/avisek/nixos";
      nrbr = "nrb && reboot";
      nfu = "nix flake update --flake /home/avisek/nixos";
      ngc = "sudo nix-collect-garbage -d && nrb";
      ngcr = "ngc && reboot";
    };
  };

  # https://nixos.wiki/wiki/Zsh#Example_Configuration
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake /home/avisek/nixos";
      nrb = "sudo nixos-rebuild boot --flake /home/avisek/nixos";
      nrbr = "nrb && reboot";
      nfu = "nix flake update --flake /home/avisek/nixos";
      ngc = "sudo nix-collect-garbage -d && nrb";
      ngcr = "ngc && reboot";
    };
  };

  # https://nixos.wiki/wiki/Git#Configuration
  programs.git = {
    enable = true;
    userName = "Avisek Das";
    userEmail = "avisekdas555@gmail.com";
  };

  # # https://nixos.wiki/wiki/GNOME#Dark_mode
  # # https://www.reddit.com/r/NixOS/comments/18hdool/comment/kd8m9v7/
  # dconf = {
  #   enable = true;
  #   settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  # };
}
