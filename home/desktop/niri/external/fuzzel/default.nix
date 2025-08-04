{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.packages = with pkgs; [
      fuzzel
    ];

    # Fuzzel 启动器配置
    # 可选主题：
    # - ./fuzzel.ini (默认深色主题)
    # - ./fuzzel-macos-glass.ini (macOS 毛玻璃效果 - 深色，推荐)
    # - ./fuzzel-macos-glass-light.ini (macOS 毛玻璃效果 - 浅色)

    # 当前使用：macOS 毛玻璃效果深色主题
    xdg.configFile."fuzzel/fuzzel.ini".source = ./fuzzel-macos-glass.ini;

    # 确保安装 LXGW WenKai Mono 字体以获得最佳显示效果
    # 字体包通常在系统级别安装，这里添加注释提醒

  };
}
