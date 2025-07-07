{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.bluetooth;
in
{
  # 蓝牙核心功能实现（包含设备和工具支持）
  config = lib.mkIf cfg.enable {
    # 启用蓝牙硬件支持
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = cfg.powerOnBoot;
      
      settings = {
        General = {
          # 基础配置文件
          Enable = "Source,Sink,Media,Socket" + (lib.optionalString cfg.inputDevices ",Control");
          
          # 实验性功能
          Experimental = cfg.experimental;
          
          # 基础配置
          DiscoverableTimeout = 0;
          PairableTimeout = 0;
        };
        
        Policy = {
          AutoEnable = true;
        };
      };
    };

    # 基础蓝牙工具和包
    environment.systemPackages = with pkgs; (
      [ 
        bluez             # 蓝牙协议栈
        bluez-tools       # 蓝牙工具集
        bluetuith         # TUI 蓝牙管理器
      ] ++ 
      # 图形管理工具
      (lib.optionals cfg.gui [
        blueman           # 蓝牙管理器GUI
        blueberry         # 简单蓝牙管理器
      ])
    );

    # 蓝牙服务
    systemd.services.bluetooth.enable = true;
    
    # 输入设备支持
    boot.kernelModules = lib.optionals cfg.inputDevices [ "hid_generic" "uinput" ];
    
    # GUI 管理工具服务
    services.blueman.enable = lib.mkIf cfg.gui true;
    
    # 用户组权限
    users.groups.bluetooth = {};
    
    # 设备权限
    services.udev.extraRules = ''
      # 蓝牙设备权限
      KERNEL=="rfkill", SUBSYSTEM=="rfkill", GROUP="bluetooth", MODE="0664"
      SUBSYSTEM=="bluetooth", GROUP="bluetooth", MODE="0664"
    '';
  };
}
