{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    # Rofi 应用启动器配置
    # 支持 macOS 毛玻璃效果主题
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;

      # 主题选择（可选配置）：
      # - ./config.rasi (现代化配置，默认深色毛玻璃主题)
      # - ./macos-glass-dark.rasi (macOS 深色毛玻璃主题)
      # - ./macos-glass-light.rasi (macOS 浅色毛玻璃主题)

      # 当前使用：现代化配置（包含 macOS 毛玻璃深色主题）
      theme = ./config.rasi;

      # 可选：直接使用特定主题
      # theme = ./macos-glass-dark.rasi;    # 深色主题
      # theme = ./macos-glass-light.rasi;   # 浅色主题
    };

    # 确保安装必需的字体和图标
    # 注意：这些通常在系统级别配置，这里添加注释提醒
    # fonts.packages = with pkgs; [ lxgw-wenkai ];
    # environment.systemPackages = with pkgs; [ papirus-icon-theme ];

    # 主题切换脚本（可选）
    home.file.".local/bin/rofi-theme-switcher" = {
      source = ./theme-switcher.sh;
      executable = true;
    };

  };
}
