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
        wifite2             # WiFi 网络扫描
        kismet              # 无线网络检测
        horst               # WiFi 协议分析器
      ];
    })
    
    # WiFi 安全工具
    (lib.mkIf (config.mySystem.services.drivers.wifi.enable && config.mySystem.services.drivers.wifi.tools.security) {
      environment.systemPackages = with pkgs; [
        aircrack-ng         # WiFi 安全审计
        hashcat             # 密码破解
        reaver              # WPS 安全测试
        pixiewps            # WPS PIN 攻击
      ];
    })
    
    # 高级 WiFi 工具
    (lib.mkIf (config.mySystem.services.drivers.wifi.enable && config.mySystem.services.drivers.wifi.tools.advanced) {
      environment.systemPackages = with pkgs; [
        wireshark           # 网络包分析
        tcpdump             # 包捕获
        hcxtools            # WiFi 分析工具套件
        bettercap           # 网络攻击框架
      ];
    })
  ];
}
