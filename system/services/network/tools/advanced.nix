{ config, lib, pkgs, ... }:

{
  # 高级网络工具实现
  config = lib.mkMerge [
    # 网络扫描工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.advanced.scanning) {
      environment.systemPackages = with pkgs; [
        # 端口和服务扫描
        nmap
        masscan
        zmap
        
        # 网络发现
        arp-scan
        
        # 漏洞扫描
        nikto
        
        # 服务枚举
        enum4linux
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
        # 网络配置自动化
        ansible
        
        # 网络编程
        python3Packages.scapy
        python3Packages.netaddr
        python3Packages.requests
        
        # 网络脚本工具
        jq        # JSON 处理
        yq        # YAML 处理
        
        # API 测试
        postman
      ];
    })
  ];
}
