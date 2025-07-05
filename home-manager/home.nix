{ config, pkgs, ... }:

{
  imports = [
    # 使用新的模块化配置
    ../modules/home-manager
    
    # 保留原有的应用配置 (可选)
    # ./apps/zsh.nix
    # ./apps/micro.nix
  ];
  
  # 基础配置
  home.username = "hengvvang";
  home.homeDirectory = "/home/hengvvang";
  home.stateVersion = "25.05";

  # 基础软件包 (其他包在模块中管理)
  home.packages = with pkgs; [
    hello
    htop
  ];  # 文件配置示例
  home.file = {
    # 可以在这里添加特定的配置文件
    # 例如：自定义脚本、配置文件等
    
    # 示例：创建一个欢迎脚本
    ".local/bin/welcome".text = ''
      #!/bin/bash
      echo "🎉 欢迎使用 NixOS + Home Manager!"
      echo "📅 今天是: $(date '+%Y年%m月%d日')"
      echo "🏠 主目录: $HOME"
      echo "🐚 Shell: $SHELL"
    '';
  };

  # 环境变量配置 (模块中也有更详细的配置)
  home.sessionVariables = {
    EDITOR = "micro";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  # 启用 Home Manager
  programs.home-manager.enable = true;
}
