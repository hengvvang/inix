{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # 基础网络工具
    (lib.mkIf config.mySystem.services.network.tools.enable {
      environment.systemPackages = with pkgs; [
        # 基础网络工具
        wget
        curl
        nmap
        netcat-gnu
        tcpdump
        wireshark
        dig
        whois
        traceroute
        mtr
        iperf3
        
        # 现代替代工具
        httpie      # 现代 curl
        dog         # 现代 dig
        bandwhich   # 网络带宽监控
      ];
    })

    # 网络监控工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.monitoring) {
      environment.systemPackages = with pkgs; [
        # 网络监控
        nethogs     # 按进程显示网络使用
        iftop       # 网络流量监控
        bmon        # 带宽监控
        vnstat      # 网络统计
        speedtest-cli
        
        # 系统监控
        htop
        iotop
        atop
        glances     # 系统监控工具
      ];
      
      # 启用 vnStat 服务
      services.vnstat.enable = true;
    })

    # 网络安全工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.security) {
      environment.systemPackages = with pkgs; [
        # 安全扫描
        nmap
        masscan
        rustscan
        
        # 网络抓包分析
        wireshark
        tshark
        tcpdump
        
        # 安全测试
        hping
        ettercap
        aircrack-ng
        
        # VPN 和隧道
        openvpn
        openconnect
        
        # 防火墙管理
        ufw
        iptables
      ];
      
      # UFW 防火墙 (简化的 iptables 前端)
      networking.firewall.enable = lib.mkDefault true;
      
      # 包过滤和安全
      networking.firewall = {
        # 拒绝 ping
        allowPing = false;
        
        # 记录拒绝的连接
        logRefusedConnections = true;
        
        # 拒绝未授权的端口探测
        logRefusedPackets = true;
      };
    })
  ];
}
