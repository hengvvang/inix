# 系统级 Stylix 配置示例
# 在 hosts/*/system.nix 中使用

{ config, pkgs, lib, ... }:

{
  # 启用系统级 Stylix 配置
  mySystem.profiles.stylix = {
    enable = true;
    polarity = "dark";  # 或 "light"
    
    # 壁纸配置
    wallpapers = {
      enable = true;
      preset = "sea";  # 可选：sea, home, maori, pixabay, blue-sky
      # custom = /path/to/custom/wallpaper.jpg;  # 可选自定义壁纸
    };
    
    # 字体配置（使用默认值，也可自定义）
    fonts = {
      enable = true;
      # 如需自定义，可以覆盖包和名称
      # packages.monospace = pkgs.nerd-fonts.fira-code;
      # names.monospace = "FiraCode Nerd Font Mono";
    };
    
    # 颜色配置
    colors = {
      enable = true;
      scheme = "warm-white";  # 推荐的默认方案
      # 可选的颜色覆盖
      # override = {
      #   base00 = "fefefe";  # 自定义背景色
      #   base05 = "444444";  # 自定义前景色
      # };
    };
    
    # 目标应用配置（仅系统级组件）
    targets = {
      enable = true;
      
      # 系统启动
      boot = {
        grub.enable = true;  # 启用 GRUB 主题
      };
      
      # 系统桌面
      desktop = {
        gtk.enable = true;   # 启用系统级 GTK 主题
      };
      
      # 系统控制台
      console.enable = true; # 启用控制台主题
    };
  };
}
