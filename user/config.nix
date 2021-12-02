{ pkgs, ... }:

let
  emacsPkgs = with pkgs; [
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

  musicPkgs = with pkgs; [
    unrar
    shntool
  ];

  videoPkgs = with pkgs; [
    vlc
  ];

  devPkgs = with pkgs; [
    google-chrome
    firefox

    caddy
    calibre
    cntr
    clinfo
    docker
    dos2unix
    gcc
    git
    glibc
    gnumake
    graphviz
    konsole
    librime
    massif-visualizer
    nix-prefetch
    ntfs3g
    okular
    patchelf
    rsync
    sqlite
    upx
    valgrind
    zdns
    tree
    openssl
    multimarkdown
    unzip

    wpsoffice
    nixpkgs-review
  ];

  androidPkgs = with pkgs; [
    android-studio
    openjdk11
    gradle
    kotlin
    kotlin-language-server
  ];
in
{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; rec {
    myEnv = pkgs.buildEnv {
      name = "my-env";
      paths = devPkgs
        ++ emacsPkgs
        ++ musicPkgs
        ++ androidPkgs
        ++ videoPkgs
      ;
    };
  };
}
