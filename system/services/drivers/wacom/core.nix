{ config, lib, pkgs, ... }:

{
  # Wacom 核心驱动实现
  config = lib.mkMerge [
    # Xorg Wacom 驱动
    (lib.mkIf (config.mySystem.services.drivers.wacom.enable && config.mySystem.services.drivers.wacom.driver.xorg) {
      services.xserver.wacom.enable = true;
      
      environment.systemPackages = with pkgs; [
        xf86_input_wacom     # Xorg Wacom 驱动
        libwacom             # Wacom 设备数据库
      ];
    })
    
    # OpenTabletDriver 开源驱动
    (lib.mkIf (config.mySystem.services.drivers.wacom.enable && config.mySystem.services.drivers.wacom.driver.opentablet) {
      hardware.opentabletdriver = {
        enable = true;
        daemon.enable = true;
      };
      
      environment.systemPackages = with pkgs; [
        opentabletdriver
      ];
    })
    
    # 传统驱动支持
    (lib.mkIf (config.mySystem.services.drivers.wacom.enable && config.mySystem.services.drivers.wacom.driver.legacy) {
      environment.systemPackages = with pkgs; [
        wacomtablet          # KDE Wacom 配置
        xsetwacom            # X11 Wacom 设置工具
      ];
    })
    
    # 基础设备权限
    (lib.mkIf config.mySystem.services.drivers.wacom.enable {
      services.udev.extraRules = ''
        # Wacom 设备权限
        SUBSYSTEM=="usb", ATTRS{idVendor}=="056a", GROUP="input", MODE="0664"
        SUBSYSTEM=="hidraw", ATTRS{idVendor}=="056a", GROUP="input", MODE="0664"
      '';
      
      # 内核模块
      boot.kernelModules = [ "wacom" "hid_wacom" ];
    })
  ];
}
