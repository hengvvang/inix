{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.drivers.enable && config.mySystem.services.drivers.network.enable && config.mySystem.services.drivers.network.wifi.enable) {
    # WiFi 驱动和工具
    networking.wireless.enable = false; # 使用 NetworkManager
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.powersave = false;
    
    # WiFi 固件
    hardware.enableRedistributableFirmware = true;
    
    # WiFi 工具包
    environment.systemPackages = with pkgs; [
      networkmanagerapplet
      wifi-qr
      wavemon
    ];
  };
}
