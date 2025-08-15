{ config, lib, pkgs, ... }:

{
  # WiFi 核心功能实现
  config = lib.mkIf config.mySystem.services.drivers.wifi.enable {
    # WiFi 固件支持
    hardware.enableRedistributableFirmware = lib.mkIf config.mySystem.services.drivers.wifi.firmware.redistributable true;
    hardware.enableAllFirmware = lib.mkIf config.mySystem.services.drivers.wifi.firmware.nonfree true;
    
    # 内核模块
    boot.kernelModules = [ "cfg80211" "mac80211" ];
    
    # 基础 WiFi 工具
    environment.systemPackages = with pkgs; [
      wirelesstools   # iwconfig, iwlist 等经典工具
      iw             # 现代 WiFi 配置工具
    ];
    
    # WiFi 设备权限
    services.udev.extraRules = ''
      # WiFi 设备权限
      SUBSYSTEM=="net", ATTR{type}=="1", GROUP="wheel", MODE="0664"
    '';
    
    # 启用 WiFi 相关服务
    systemd.services.wpa_supplicant.enable = lib.mkDefault false;
  };
}
