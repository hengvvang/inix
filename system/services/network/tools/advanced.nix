{ config, lib, pkgs, ... }:

{
  # 高级网络工具实现
  config = lib.mkMerge [
    # 网络扫描工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.advanced.scanning) {
      environment.systemPackages = with pkgs; [
        # 基础网络扫描
        nmap
        arp-scan
      ];
    })
    
    # 网络测试工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.advanced.testing) {
      environment.systemPackages = with pkgs; [
        # 负载测试
        ab        # Apache Bench
        wrk       # HTTP 负载测试
        
        # 网络压力测试
        iperf3
        netperf
        
        # 协议测试
        scapy
      ];
    })
    
    # 网络自动化工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.advanced.automation) {
      environment.systemPackages = with pkgs; [
        # JSON/YAML 处理
        jq        # JSON 处理
        yq        # YAML 处理
        
        # 网络编程基础
        python3Packages.requests
      ];
    })
  ];
}
