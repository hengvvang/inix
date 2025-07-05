# 服务器 Home Manager 配置示例
{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  imports = [ ../../home ];
  
  # 基础配置
  home.username = "admin";
  home.homeDirectory = "/home/admin";
  home.stateVersion = "25.05";

  # 服务器 Home Manager 模块配置 - 开发者工具为主，无图形应用
  myHome = {
    apps.enable = false;        # 无图形应用 - 服务器无需编辑器GUI
    development.enable = true;  # 开发环境 - 保留命令行工具
    profiles.enable = false;    # 无字体配置 - 服务器无图形界面
    toolkits.enable = true;     # 系统工具 - 服务器管理必需
  };

  # 服务器专用环境变量
  home.sessionVariables = {
    EDITOR = "vim";
    PAGER = "less";
  };

  programs.home-manager.enable = true;
}
