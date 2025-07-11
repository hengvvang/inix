{ config, lib, pkgs, ... }:

{
  options.mySystem.pkgs.toolkits = {
    enable = lib.mkEnableOption "命令行工具包支持";
    
    # 文件管理工具
    files = {
      enable = lib.mkEnableOption "文件管理工具";
    };
    
    # 文本处理工具
    text = {
      enable = lib.mkEnableOption "文本处理工具";
    };
    
    # 网络工具
    network = {
      enable = lib.mkEnableOption "网络工具";
    };
    
    # 系统监控工具
    monitor = {
      enable = lib.mkEnableOption "系统监控工具";
    };
    
    # 开发工具
    develop = {
      enable = lib.mkEnableOption "开发辅助工具";
    };
  };

  imports = [
    ./files.nix
    ./text.nix
    ./network.nix
    ./monitor.nix
    ./develop.nix
  ];
}
