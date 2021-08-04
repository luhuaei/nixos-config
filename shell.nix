{ config, pkgs, ... }:

{
  imports = [
    # resolve /usr/bin /use/sbin
    ''${builtins.fetchTarball "https://github.com/Mic92/envfs/archive/main.tar.gz"}/modules/envfs.nix''
  ];

  environment.systemPackages = with pkgs; [
    direnv
    lorri
    zsh
    oh-my-zsh
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
  programs.zsh.ohMyZsh = {
    enable = true;
    theme = "josh";
  };
}
