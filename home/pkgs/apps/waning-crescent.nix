# 🌘 残月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.waningCrescent.enable {
    home.packages = with pkgs; [
      
      # steam
      # lutris
      
      # blender           # 3D 建模
      # gimp              # 图像编辑
      # inkscape          # 矢量图编辑
      # davinci-resolve   # 视频编辑 (需要 unfree)
      
      # virtualbox        # VirtualBox (需要 unfree)
      
      # 系统工具
      # gparted           # 分区工具
    ];
  };
}
