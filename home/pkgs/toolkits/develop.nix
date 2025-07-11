{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.toolkits.develop.enable {
    home.packages = with pkgs; [
      # 性能测试
      hyperfine       # 基准测试工具
      
      # 代码统计
      tokei           # 代码统计
      
      # 文件监控
      watchexec       # 文件监控执行
      
      # 图像处理
      imagemagick     # 图像处理套件
    ];
  };
}
