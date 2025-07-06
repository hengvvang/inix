{ config, lib, pkgs, ... }:

{
  # WiFi 工具实现
  config = lib.mkMerge [
    # 图形界面工具
    (lib.mkIf (config.mySystem.services.drivers.wifi.enable && config.mySystem.services.drivers.wifi.tools.gui) {
      environment.systemPackages = with pkgs; [
        networkmanagerapplet  # NetworkManager GUI
        wifi-qr              # WiFi 二维码生成
      ];
    })
    
    # WiFi 监控工具
    (lib.mkIf (config.mySystem.services.drivers.wifi.enable && config.mySystem.services.drivers.wifi.tools.monitoring) {
      environment.systemPackages = with pkgs; [
        wavemon             # WiFi 监控工具
      ];
    })
    
    # WiFi 安全工具
    (lib.mkIf (config.mySystem.services.drivers.wifi.enable && config.mySystem.services.drivers.wifi.tools.security) {
      environment.systemPackages = with pkgs; [
        # 基础网络分析工具
        wireshark           # 网络包分析
      ];
    })
  ];
}
