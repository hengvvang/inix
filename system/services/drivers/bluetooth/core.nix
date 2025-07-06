{ config, lib, pkgs, ... }:

{
  # 蓝牙核心功能实现
  config = lib.mkIf config.mySystem.services.drivers.bluetooth.enable {
    # 启用蓝牙硬件支持
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = config.mySystem.services.drivers.bluetooth.core.powerOnBoot;
      
      settings = {
        General = {
          # 启用所有基础配置文件
          Enable = "Source,Sink,Media,Socket";
          
          # 实验性功能
          Experimental = config.mySystem.services.drivers.bluetooth.core.experimental;
          
          # 快速连接模式
          FastConnectable = config.mySystem.services.drivers.bluetooth.core.fastConnectable;
          
          # 默认配置
          DiscoverableTimeout = 0;
          PairableTimeout = 0;
        };
        
        # 策略配置
        Policy = {
          AutoEnable = true;
        };
      };
    };
    
    # 基础蓝牙工具
    environment.systemPackages = with pkgs; [
      bluez             # 蓝牙协议栈
      bluez-tools       # 蓝牙工具集
    ];
    
    # 蓝牙服务
    systemd.services.bluetooth.enable = true;
    
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
