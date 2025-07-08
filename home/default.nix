{ config, lib, pkgs, ... }:

{
  imports = [
    ./develop
    ./profiles
    ./dotfiles
    ../pkgs
  ];

  myHome = {
    # Dotfiles 配置管理
    dotfiles = {
      enable = lib.mkDefault false;
      vim.enable = lib.mkDefault false;
      zsh.enable = lib.mkDefault false;
      fish.enable = lib.mkDefault false;
      nushell.enable = lib.mkDefault false;
      yazi.enable = lib.mkDefault false;
      ghostty.enable = lib.mkDefault false;
      git.enable = lib.mkDefault false;
      lazygit.enable = lib.mkDefault false;
      starship.enable = lib.mkDefault false;
      proxy = {
        enable = lib.mkDefault false;
      };
    };
    
    # 开发环境配置
    develop = {
      enable = lib.mkDefault false;
      languages = {
        enable = lib.mkDefault false;
        rust.enable = lib.mkDefault false;
        python.enable = lib.mkDefault false;
        javascript.enable = lib.mkDefault false;
        typescript.enable = lib.mkDefault false;
        cpp.enable = lib.mkDefault false;
        c.enable = lib.mkDefault false;
      };
      embedded = {
        enable = lib.mkDefault false;
        toolchain.enable = lib.mkDefault false;
      };
    };
    
    # 用户配置档案
    profiles = {
      enable = lib.mkDefault false;
      fonts = {
        enable = lib.mkDefault false;
        fonts.enable = lib.mkDefault false;
      };
    };
  };
  
  # 包管理配置
  myPkgs = {
    enable = lib.mkDefault false;               # 包管理模块总开关
    
    # 命令行工具包配置
    toolkits = {
      enable = lib.mkDefault false;
      files.enable = lib.mkDefault false;         # 文件管理工具
      text.enable = lib.mkDefault false;          # 文本处理工具
      network.enable = lib.mkDefault false;       # 网络工具
      monitor.enable = lib.mkDefault false;       # 系统监控工具
      development.enable = lib.mkDefault false;   # 开发辅助工具
    };
  };
}
