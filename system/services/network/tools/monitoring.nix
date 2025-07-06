{ config, lib, pkgs, ... }:

{
  # 网络监控工具实现
  config = lib.mkMerge [
    # 流量监控工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.monitoring.traffic) {
      environment.systemPackages = with pkgs; [
        # 实时流量监控
        iftop
        nethogs
        vnstat
        
        # 带宽监控
        bandwhich
        speedtest-cli
        
        # 网络统计
        ss
        netstat
      ];
    })
    
    # 性能测试工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.monitoring.performance) {
      environment.systemPackages = with pkgs; [
        # 带宽测试
        iperf3
        iperf2
        
        # 延迟测试
        ping
        fping
        hping
        
        # 吞吐量测试
        netperf
      ];
    })
    
    # 网络分析工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.monitoring.analysis) {
      environment.systemPackages = with pkgs; [
        # 协议分析
        wireshark
        tshark
        tcpdump
        
        # 流量分析
        ntopng
        
        # 网络拓扑
        nmap
        zmap
      ];
    })
  ];
}
