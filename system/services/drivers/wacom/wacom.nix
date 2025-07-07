{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.wacom;
in
{
  config = lib.mkIf cfg.enable {
    # Xorg Wacom 驱动
    services.xserver.wacom.enable = lib.mkIf cfg.driver.xorg true;
    
    # 输入设备支持
    boot.kernelModules = [ "wacom" ];
    
    # 基础 Wacom 包
    environment.systemPackages = with pkgs; [
      # 核心驱动和库
      xf86_input_wacom    # Xorg 驱动
      libwacom            # Wacom 设备库
    ]
    # OpenTabletDriver
    ++ lib.optionals cfg.driver.opentablet [
      opentabletdriver    # 开源驱动
    ]
    # 配置工具
    ++ lib.optionals cfg.tools [
      wacomtablet         # KDE Wacom 配置工具
      xsetwacom           # 命令行配置工具
    ];
    
    # 设备权限
    services.udev.extraRules = ''
      # Wacom 数位板权限
      ATTRS{idVendor}=="056a", GROUP="input", MODE="0664"
    '';
    
    # 用户组
    users.groups.input = {};
    
    # 自动配置常用 Wacom 设备
    services.udev.packages = [ pkgs.libwacom ];
  };
}
