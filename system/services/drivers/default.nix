{ config, lib, pkgs, ... }:

{
  options.mySystem.services.drivers = {
    enable = lib.mkEnableOption "硬件驱动服务";
    
    # 显卡驱动
    graphics = {
      enable = lib.mkEnableOption "显卡驱动配置";
      nvidia = {
        enable = lib.mkEnableOption "NVIDIA 显卡驱动";
        openSource = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "使用开源 NVIDIA 驱动";
        };
        powerManagement = lib.mkEnableOption "NVIDIA 电源管理";
        settings = lib.mkEnableOption "NVIDIA 设置工具";
      };
      amd.enable = lib.mkEnableOption "AMD 显卡驱动";
      intel.enable = lib.mkEnableOption "Intel 显卡驱动";
    };
    
    # 输入设备驱动
    input = {
      enable = lib.mkEnableOption "输入设备驱动";
      touchpad.enable = lib.mkEnableOption "触摸板支持";
      wacom.enable = lib.mkEnableOption "Wacom 数位板支持";
    };
    
    # 网络驱动
    network = {
      enable = lib.mkEnableOption "网络驱动";
      wifi.enable = lib.mkEnableOption "WiFi 驱动";
      bluetooth.enable = lib.mkEnableOption "蓝牙驱动";
      ethernet.enable = lib.mkEnableOption "以太网驱动";
    };
    
    # 存储驱动
    storage = {
      enable = lib.mkEnableOption "存储驱动";
      ssd.enable = lib.mkEnableOption "SSD 优化";
      usb.enable = lib.mkEnableOption "USB 设备支持";
    };
  };

  imports = [
    ./graphics
    ./input
    ./network
    ./storage
  ];
}
