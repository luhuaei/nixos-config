{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager = {
      xfce = {
        enable = true;
      };
    };
    libinput.enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
  };
  services.picom = {
    enable = true;
    fade = true;
    inactiveOpacity = 0.9;
    shadow = true;
    fadeDelta = 4;
  };

  services.upower.enable = true;
  systemd.services.upower.enable = true;
}
