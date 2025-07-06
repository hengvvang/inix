{ config, lib, pkgs, ... }:

{
  # WiFi 网络管理器实现
  config = lib.mkMerge [
    # NetworkManager
    (lib.mkIf (config.mySystem.services.drivers.wifi.enable && 
               config.mySystem.services.drivers.wifi.manager.type == "networkmanager") {
      networking.networkmanager = {
        enable = true;
        wifi.powersave = config.mySystem.services.drivers.wifi.manager.powersave;
        wifi.macAddress = "random";  # 隐私保护
      };
      
      networking.wireless.enable = false;  # 禁用 wpa_supplicant
      
      environment.systemPackages = with pkgs; [
        networkmanager
        networkmanagerapplet  # GUI 应用
      ];
    })
    
    # wpa_supplicant
    (lib.mkIf (config.mySystem.services.drivers.wifi.enable && 
               config.mySystem.services.drivers.wifi.manager.type == "wpa_supplicant") {
      networking.wireless = {
        enable = true;
        userControlled.enable = true;
      };
      
      networking.networkmanager.enable = false;
      
      environment.systemPackages = with pkgs; [
        wpa_supplicant
        wpa_supplicant_gui
      ];
    })
    
    # iwd (Intel's WiFi daemon)
    (lib.mkIf (config.mySystem.services.drivers.wifi.enable && 
               config.mySystem.services.drivers.wifi.manager.type == "iwd") {
      networking.wireless.iwd = {
        enable = true;
        settings = {
          General = {
            EnableNetworkConfiguration = true;
          };
          Network = {
            EnableIPv6 = true;
          };
        };
      };
      
      networking.networkmanager.enable = false;
      networking.wireless.enable = false;
      
      environment.systemPackages = with pkgs; [
        iwd
      ];
    })
  ];
}
