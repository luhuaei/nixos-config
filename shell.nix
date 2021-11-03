{ config, pkgs, ... }:

{
  imports = [
    # resolve /usr/bin /use/sbin
    <envfs/modules/envfs.nix>
  ];

  environment.systemPackages = with pkgs; [
    bash
    direnv
    lorri
    zsh
    oh-my-zsh
  ];
  services.lorri.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    interactiveShellInit = ''eval "$(direnv hook zsh)"'';
  };
  programs.zsh.ohMyZsh = {
    enable = true;
    theme = "josh";
  };
}
