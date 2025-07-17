# 🌘 残月

{ config, lib, pkgs, ... }:

let
  cfg = config.myPkgs;
in
{
  config = lib.mkMerge [
    # Home 配置
    (lib.mkIf (cfg.enable && cfg.target == "home" && cfg.apps.waningCrescent.enable) {
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
    })
    
    # System 配置  
    (lib.mkIf (cfg.enable && cfg.target == "system" && cfg.apps.waningCrescent.enable) {
      environment.systemPackages = with pkgs; [
        
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
    })
  ];
}
