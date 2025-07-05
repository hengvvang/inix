{ config, lib, pkgs, ... }:

{
  # 系统层默认配置策略
  config = {
    mySystem = {
      # 硬件配置 - 默认开启，系统基础需求
      hardware.enable = lib.mkDefault true;
      # 用户配置 - 默认开启，系统必需
      users.enable = lib.mkDefault true;
      # 本地化 - 默认开启，中文环境常用
      localization.enable = lib.mkDefault true;
      # 桌面环境 - 默认关闭，让用户选择是否需要图形界面
      desktop.enable = lib.mkDefault false;
      # 系统包 - 默认关闭，避免安装过多不需要的软件
      packages.enable = lib.mkDefault false;
    };
  };

  imports = [
    ./desktop
    ./hardware.nix
    ./localization
    ./users.nix
    ./packages.nix
  ];
}
