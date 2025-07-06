{ config, lib, pkgs, ... }:

{
  # 以太网工具实现
  config = lib.mkMerge [
    # 基础网络工具
    (lib.mkIf (config.mySystem.services.drivers.ethernet.enable && config.mySystem.services.drivers.ethernet.tools.basic) {
      environment.systemPackages = with pkgs; [
        ethtool           # 以太网配置工具
        mii-tool          # 媒体独立接口工具
        net-tools         # 传统网络工具
        iproute2          # 现代网络工具
      ];
    })
    
    # 网络监控工具
    (lib.mkIf (config.mySystem.services.drivers.ethernet.enable && config.mySystem.services.drivers.ethernet.tools.monitoring) {
      environment.systemPackages = with pkgs; [
        iftop             # 实时流量监控
        nethogs           # 进程网络使用
        vnstat            # 网络统计
        bmon              # 带宽监控
        nload             # 网络负载监控
      ];
    })
    
    # 网络测试工具
    (lib.mkIf (config.mySystem.services.drivers.ethernet.enable && config.mySystem.services.drivers.ethernet.tools.testing) {
      environment.systemPackages = with pkgs; [
        iperf3            # 网络性能测试
        netperf           # 网络基准测试
        speedtest-cli     # 网速测试
        mtr               # 网络诊断工具
        tcptraceroute     # TCP 路由追踪
      ];
    })
  ];
}
