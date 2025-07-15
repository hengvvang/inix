# 🌖 亏凸月 - 高级生产力工具
# 提供系统管理、备份和高级工具
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.waningGibbous.enable {
    environment.systemPackages = with pkgs; [
      # 高级PDF工具
      kdePackages.okular  # KDE PDF 阅读器
      
      # 高级密码管理
      bitwarden         # 云端密码管理器
      
      # 系统备份和清理
      timeshift         # 系统备份
      bleachbit         # 系统清理
      
      # 图像查看
      feh               # 轻量级图像查看器
      
      # 音频控制
      pavucontrol       # PulseAudio 音量控制
      playerctl         # 媒体播放器控制
      
      # 截图工具
      flameshot         # 截图工具
    ];
  };
}
