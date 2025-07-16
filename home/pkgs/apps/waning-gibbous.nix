# 🌖 亏凸月 - 桌面生产力套件

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.waningGibbous.enable {
    home.packages = with pkgs; [
      
      # 主流浏览器
      # google-chrome     # Google Chrome 浏览器 (需要 unfree)
      firefox           # Firefox 浏览器
      
      # 通讯工具
      telegram-desktop  # Telegram
      discord           # Discord
      # qq                # QQ (可能需要特殊处理)
      # wechat-uos        # 微信 (可能需要特殊处理)
      
      # 办公软件
      # wpsoffice-cn      # WPS Office (需要 unfree)
      # pot               # 翻译工具
      
      # 媒体工具
      # spotify           # Spotify 音乐 (需要 unfree)
      # obs-studio        # OBS Studio 录屏
      vlc               # VLC 播放器
      
    ];
  };
}
