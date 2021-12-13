{ config, lib, pkgs, ... }:

let
  overlay-unstable = final: prev: {
    unstable = pkgs.nixUnstable.legacyPackages.${prev.system}; # considering nixpkgs-unstable is an input registered before.
  };
in
{
  nix.binaryCaches = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  ];

  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    gc-keep-outputs = true
    gc-keep-derivations = true
  '';
  nix.maxJobs = "auto";
  nix.autoOptimiseStore = true;
  nix.buildCores = 0;

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };
  };
}
