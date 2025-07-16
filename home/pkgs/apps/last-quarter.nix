# 🌗 下弦月 - 开发和终端应用

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.lastQuarter.enable {
    home.packages = with pkgs; [
      
      # 开发编辑器 (注释掉的可根据需要启用)
      # vscode          # Visual Studio Code
      # zed-editor      # Zed 编辑器
      
      # 进阶终端工具
      alacritty         # 现代终端
      kitty             # 另一个现代终端
      
      # 文件管理器
      yazi              # 现代文件管理器
      
    ];
  };
}
