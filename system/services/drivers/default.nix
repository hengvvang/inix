{ config, lib, pkgs, ... }:

{
  options.mySystem.services.drivers = {
    enable = lib.mkEnableOption "硬件驱动服务";
    
    # === 原子化配置：每个功能都是独立的一级选项 ===
    
    # 显卡驱动 - 原子化，每个品牌独立
    nvidia = {
      enable = lib.mkEnableOption "NVIDIA 显卡驱动";
      powerManagement = lib.mkEnableOption "NVIDIA 电源管理";
      settings = lib.mkEnableOption "NVIDIA 设置工具";
      openSource = lib.mkEnableOption "使用开源 NVIDIA 驱动";
    };
    amd.enable = lib.mkEnableOption "AMD 显卡驱动";
    intel.enable = lib.mkEnableOption "Intel 显卡驱动";
    
    # 输入设备驱动 - 原子化，每种设备独立
    touchpad.enable = lib.mkEnableOption "触摸板驱动";
    wacom.enable = lib.mkEnableOption "Wacom 数位板驱动";
    
    # 网络驱动 - 原子化，每种技术独立
    wifi.enable = lib.mkEnableOption "WiFi 驱动";
    bluetooth.enable = lib.mkEnableOption "蓝牙驱动";
    ethernet.enable = lib.mkEnableOption "以太网驱动";
    
    # 存储驱动 - 原子化，每种类型独立
    ssd.enable = lib.mkEnableOption "SSD 优化";
    usb.enable = lib.mkEnableOption "USB 设备支持";
    
    # 从system/hardware迁移的驱动 - 原子化
    audio.enable = lib.mkEnableOption "音频驱动 (PipeWire)";
    printing.enable = lib.mkEnableOption "打印机驱动 (CUPS)";
  };

  imports = [
    # === 原子化导入：每个功能都有独立的文件夹 ===
    # 显卡驱动文件夹
    ./nvidia/default.nix
    ./amd/default.nix  
    ./intel/default.nix
    
    # 输入设备文件夹
    ./touchpad/default.nix
    ./wacom/default.nix
    
    # 网络驱动文件夹
    ./wifi/default.nix
    ./bluetooth/default.nix
    ./ethernet/default.nix
    
    # 存储驱动文件夹
    ./ssd/default.nix
    ./usb/default.nix
    
    # 从hardware迁移的驱动文件夹
    ./audio/default.nix
    ./printing/default.nix
  ];
}
