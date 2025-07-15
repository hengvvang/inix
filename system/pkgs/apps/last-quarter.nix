# 🌗 下弦月 - 媒体和创意工具
# 提供多媒体处理、图像编辑和创意工具
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.lastQuarter.enable {
    environment.systemPackages = with pkgs; [
      # 图像编辑
      gimp              # 图像编辑器
      inkscape          # 矢量图形编辑器
      
      # 音频处理
      audacity          # 音频编辑器
      
      # 视频处理
      vlc               # 万能媒体播放器
      mpv               # 轻量级媒体播放器
      obs-studio        # 直播和录屏软件
      kdePackages.kdenlive  # 视频编辑器
      
      # 音乐播放
      rhythmbox         # 音乐播放器
      
      # 录屏工具
      peek              # GIF 录制工具
      
      # 颜色工具
      gpick             # 颜色选择器
    ];
  };
}
