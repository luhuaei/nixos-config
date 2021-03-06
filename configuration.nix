# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./boot.nix
      ./init.nix
      ./shell.nix
      ./network.nix
      ./language.nix
      ./wm.nix
      ./virtualisation.nix

      # services
      <touchctrl-go/touchctrl.nix>
    ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };
  services.blueman.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    extraUsers.redeveder = rec {
      isNormalUser = true;
      home = "/home/redeveder";
      extraGroups = [ "wheel" "docker" "netdev" ]; # Enable ‘sudo’ for the user.
    };
  };

  environment.systemPackages = with pkgs; [
    # editor
    vim
    emacs

    # video
    mpv

    #window manager
    wmctrl

    # record
    peek
    flameshot

    # debug
    htop

    gvfs
    file

    # other libc implement
    musl

    nettools
    socat
    traceroute
    wireshark

    # system
    pciutils
    usbutils
    binutils
    inetutils
    dnsutils
    dmidecode
    lshw
    lsof
  ];
  services.gvfs.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.touchctrl = {
    enable = false;
    touchpad = "/dev/input/event11";
    keyboard = "/dev/input/event0";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}
