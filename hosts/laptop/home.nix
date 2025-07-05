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

  # 启用所有 Home Manager 模块
  myHome = {
    apps = {
      enable = true;
      yazi.enable = true;
      editors.enable = true;
    };
    development.enable = true;
    profiles.enable = true;
    toolkits.enable = true;
  };

  # 核心环境变量
  home.sessionVariables = {
    EDITOR = lib.mkDefault "vim";
    #TERMINAL = "alacritty";
  };

  # 启用 Home Manager
  programs.home-manager.enable = true;
}
