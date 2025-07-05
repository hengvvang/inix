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

  # 启用 Home Manager 模块 - 使用分层默认值
  myHome = {
    # 只需要显式启用顶层模块，子模块将使用各层的默认值
    apps.enable = true;
    development.enable = true;  
    profiles.enable = true;
    toolkits.enable = true;  # 现在启用工具包来演示分层默认值
  };

  # 核心环境变量
  home.sessionVariables = {
    EDITOR = lib.mkDefault "vim";
    #TERMINAL = "alacritty";
  };

  # 启用 Home Manager
  programs.home-manager.enable = true;
}
