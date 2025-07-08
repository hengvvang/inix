{ config, lib, pkgs, ... }:

{
  # 系统模块入口 - 仅做导入，类似 home/default.nix
  imports = [
    ./desktop
    ./users
    ./locale
    ./services
  ];

  # 所有系统模块的默认配置 - 在主机配置中按需启用
  mySystem = {
    # 桌面环境模块
    desktop = {
      enable = lib.mkDefault false;
      cosmic.enable = lib.mkDefault false;
    };
    
    # 用户配置模块
    users = {
      enable = lib.mkDefault false;
    };
    
    # 系统应用模块
    apps = {
      enable = lib.mkDefault false;
    };
    
    # 本地化配置模块
    locale = {
      enable = lib.mkDefault false;
      # 时区配置（只能选择一个）
      timeZone = {
        enable = lib.mkDefault false;
        shanghai.enable = lib.mkDefault false;
        newYork.enable = lib.mkDefault false;
        losAngeles.enable = lib.mkDefault false;
      };
      # 输入法配置（只能选择一个）
      inputMethod = {
        enable = lib.mkDefault false;
        fcitx5.enable = lib.mkDefault false;
        ibus.enable = lib.mkDefault false;
      };
    };
    
    # 服务配置模块
    services = {
      enable = lib.mkDefault false;
      network = {
        enable = lib.mkDefault false;
        proxy = {
          enable = lib.mkDefault false;
        };
      };
    };
    
  };
}
