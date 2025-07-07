{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.wifi;
in
{
  # WiFi 工具实现
  config = lib.mkMerge [
    # 图形界面工具
    (lib.mkIf (cfg.enable && cfg.tools.gui) {
      environment.systemPackages = with pkgs; [
        networkmanagerapplet  # NetworkManager GUI
        wifi-qr              # WiFi 二维码生成
      ];
    })
    
    # WiFi 监控工具
    (lib.mkIf (cfg.enable && cfg.tools.monitoring) {
      environment.systemPackages = with pkgs; [
        wavemon             # WiFi 监控工具
        iperf3              # 网络性能测试
        speedtest-cli       # 网速测试
      ];
    })
    
    # WiFi 调试和分析工具
    (lib.mkIf (cfg.enable && cfg.tools.debugging) {
      environment.systemPackages = with pkgs; [
        wireshark           # 网络包分析
        tcpdump             # 命令行包捕获
        nmap                # 网络扫描
        aircrack-ng         # WiFi 安全工具集
        iw                  # 现代 WiFi 配置工具
        iwinfo              # WiFi 信息查看
      ];
    })
  ];
}
