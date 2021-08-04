{ config, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
    inputMethod.enabled = "fcitx";
    inputMethod.fcitx.engines  = with pkgs.fcitx-engines; [ libpinyin cloudpinyin ];
  };

  fonts.fonts = with pkgs; [
    mononoki
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    open-sans
    wqy_microhei
    wqy_zenhei
  ];
}
