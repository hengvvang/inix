# 🌘 残月 - 通讯娱乐套件
# 提供通讯、娱乐、游戏和社交应用
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.waningCrescent.enable {
    environment.systemPackages = with pkgs; [
      # 即时通讯
      discord           # Discord 聊天平台
      telegram-desktop  # Telegram 即时通讯
      signal-desktop    # Signal 加密通讯
      
      # 视频会议和协作
      zoom-us           # Zoom 视频会议
      slack             # Slack 团队协作
      
      # 远程访问
      remmina           # 远程桌面客户端
      teamviewer        # TeamViewer 远程协助
      
      # 文件传输
      qbittorrent       # BitTorrent 客户端
      filezilla         # FTP 客户端
      
      # 游戏平台
      steam             # Steam 游戏平台
      lutris            # 游戏管理器
      
      # 游戏优化
      mangohud          # 游戏性能监控
      gamemode          # 游戏模式优化
      
      # 娱乐工具
      spotify           # 音乐流媒体
      yt-dlp            # YouTube 下载器
      
      # 电子书
      calibre           # 电子书管理器
      foliate           # 电子书阅读器
      
      # 3D 建模
      blender           # 3D 建模和动画
      
      # 字体工具
      fontforge         # 字体编辑器
      
      # 休闲工具
      cmatrix           # Matrix 效果
      neofetch          # 系统信息展示
      lolcat            # 彩色输出
    ];
  };
}
