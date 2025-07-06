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
      iftop             # 网络流量监控
      nethogs           # 进程网络使用
      bandwhich         # 现代网络监控
      speedtest-cli     # 网速测试
    ];
    
    # 网络优化脚本
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "ethernet-optimize" ''
        #!/bin/bash
        echo "以太网性能优化..."
        
        # 检测以太网接口
        for iface in $(ls /sys/class/net/ | grep -E '^(eth|eno|enp)'); do
          if [ -d "/sys/class/net/$iface" ]; then
            echo "优化接口: $iface"
            
            # 启用大接收分段卸载
            ethtool -K "$iface" gro on 2>/dev/null || true
            ethtool -K "$iface" lro on 2>/dev/null || true
            
            # 优化环形缓冲区
            ethtool -G "$iface" rx 4096 tx 4096 2>/dev/null || true
            
            # 启用硬件卸载
            ethtool -K "$iface" tso on 2>/dev/null || true
            ethtool -K "$iface" ufo on 2>/dev/null || true
          fi
        done
        
        echo "以太网优化完成"
      '')
    ];
  };
}
