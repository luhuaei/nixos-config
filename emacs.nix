{ config, pkgs, ... }:

{
  services.emacs.package = pkgs.emacsGit;
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];
  # daemon mode, allow use emacsclient fast open other emacs
  services.emacs.enable = true;

  environment.systemPackages = with pkgs; [
    # sdcv translator
    sdcv

    # aspell to check word spell is right?
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    # wmctrl bind key to fast open/active emacs on other window
    # set `sh -c "wmctrl -xa emacs || emacs"` to your desktopManager shortcut
    wmctrl

    # rg
    ripgrep

    nixpkgs-fmt
  ];
}
