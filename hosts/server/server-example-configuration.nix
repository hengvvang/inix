# 服务器主机配置示例
{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix  # 服务器硬件配置
    ../../system
  ];

  # 基础系统配置
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "server";
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # 服务器模块配置 - 最小化配置，无图形界面
  mySystem = {
    desktop.enable = false;     # 无桌面环境 - 服务器不需要
    hardware.enable = true;     # 硬件配置 - 基础需求
    localization.enable = false; # 无本地化 - 服务器英文环境即可
    users.enable = true;        # 用户配置 - 必需，包含SSH
    packages.enable = false;    # 无图形软件包 - 最小化安装
  };

  system.stateVersion = "25.05";
}
