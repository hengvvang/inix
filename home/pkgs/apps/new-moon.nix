# 🌑 新月 - 完整应用生态

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.newMoon.enable {
    home.packages = with pkgs; [
      
      # 游戏平台
      # steam             # Steam 游戏平台 (需要 unfree)
      # lutris            # 游戏管理器
      
      # 网络工具
      # clash-verge-rev   # 代理工具（主要）
      # clash-nyanpasu    # 代理工具（备用）
      # clash-meta        # Clash 内核
      
      # 高级开发工具
      # vscode            # Visual Studio Code (需要 unfree)
      # zed-editor        # Zed 编辑器
      
      # 专业媒体工具
      # blender           # 3D 建模
      gimp              # 图像编辑
      inkscape          # 矢量图编辑
      # davinci-resolve   # 视频编辑 (需要 unfree)
      
      # 虚拟化工具
      # virtualbox        # VirtualBox (需要 unfree)
      
      # 系统工具
      gparted           # 分区工具
      
      # 科学工具
      # mathematica       # 数学软件 (需要 unfree)
      
    ];
  };
}
