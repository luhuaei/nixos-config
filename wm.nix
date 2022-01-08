{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager = {
      plasma5 = {
        enable = true;
      };
    };
    displayManager.lightdm = {
      greeters = {
        mini = {
          enable = true;
          user = "redeveder";
        };
      };
    };
    libinput.enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
  };


  services.upower.enable = true;
  systemd.services.upower.enable = true;

  services.gpm.enable = true;
  services.kmscon = {
    enable = true;
    hwRender = true;
    extraConfig = "font-size=18";
  };
}
