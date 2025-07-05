{ config, pkgs, lib, ... }:

{
  # 允许非自由软件
  nixpkgs.config.allowUnfree = true;
  
  imports = [
    # 使用新的模块化配置
    ../../home
  ];
  
  # 基础配置
  home.username = "hengvvang";
  home.homeDirectory = "/home/hengvvang";
  home.stateVersion = "25.05";

  # Home Manager 模块配置 - 完全由主机决定启用哪些模块
  # 适合 laptop 主机：启用完整的开发和办公环境
  myHome = {
    apps.enable = true;         # 应用程序 - 编辑器、文件管理器等
    development.enable = true;  # 开发环境 - 编程语言和工具
    profiles.enable = true;     # 配置文件 - 环境变量、字体等
    toolkits.enable = true;     # 工具包 - 系统和用户工具
  };

  # 核心环境变量
  home.sessionVariables = {
    EDITOR = lib.mkDefault "vim";
    #TERMINAL = "alacritty";
  };

  # 启用 Home Manager
  programs.home-manager.enable = true;
}
