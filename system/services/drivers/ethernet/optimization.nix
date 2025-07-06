{ config, lib, pkgs, ... }:

{
  # 以太网性能优化实现
  config = lib.mkIf (config.mySystem.services.drivers.ethernet.enable && config.mySystem.services.drivers.ethernet.network.optimization) {
    # 网络性能优化内核参数
    boot.kernel.sysctl = {
      # TCP 缓冲区优化
      "net.core.rmem_max" = 134217728;
      "net.core.wmem_max" = 134217728;
      "net.ipv4.tcp_rmem" = "4096 65536 134217728";
      "net.ipv4.tcp_wmem" = "4096 65536 134217728";
      
      # TCP 优化
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_slow_start_after_idle" = 0;
      "net.ipv4.tcp_mtu_probing" = 1;
      
      # 网络队列优化
      "net.core.netdev_max_backlog" = 5000;
      "net.core.netdev_budget" = 600;
      
      # 连接跟踪优化
      "net.netfilter.nf_conntrack_max" = 1048576;
      "net.netfilter.nf_conntrack_tcp_timeout_established" = 600;
    };
    
    # 网络性能监控工具
    environment.systemPackages = with pkgs; [
      # 网络监控工具
      iftop             # 网络流量监控
      nethogs           # 进程网络使用
      speedtest-cli     # 网速测试
    ];
  };
}
