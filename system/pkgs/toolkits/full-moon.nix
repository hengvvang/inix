# 🌕 满月 - 桌面办公套件
# 提供基础的桌面应用和办公工具
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.toolkits.fullMoon.enable {
    environment.systemPackages = with pkgs; [
      # 网页浏览器
      firefox           # Firefox 浏览器
      chromium          # Chromium 浏览器
      
      # 基础办公套件
      libreoffice       # 开源办公套件
      
      # PDF 工具
      evince            # PDF 阅读器
      zathura           # 轻量级PDF阅读器
      
      # 基础文本工具
      obsidian          # 笔记管理
      
      # 邮件客户端
      thunderbird       # 邮件客户端
      
      # 密码管理
      keepassxc         # 本地密码管理器
      
      # 网络代理
      clash-verge-rev   # 代理工具
      
      # 图像处理
      imagemagick       # 图像处理套件
    ];
  };
}
