{ config, lib, pkgs, ... }:

{
  # 网络工具模块的完整选项定义
  options.mySystem.services.network.tools = {
    enable = lib.mkEnableOption "网络工具基础支持";
    
    # === 基础工具选项 ===
    basic = {
      classic = lib.mkEnableOption "经典网络工具" // { default = true; };
      modern = lib.mkEnableOption "现代网络工具" // { default = true; };
      security = lib.mkEnableOption "网络安全工具";
    };
    
    # === 监控工具选项 ===
    monitoring = {
      traffic = lib.mkEnableOption "流量监控工具";
      performance = lib.mkEnableOption "性能测试工具";
      analysis = lib.mkEnableOption "网络分析工具";
    };
    
    # === 调试工具选项 ===
    debugging = {
      packet = lib.mkEnableOption "数据包分析工具";
      trace = lib.mkEnableOption "网络追踪工具"; 
      troubleshoot = lib.mkEnableOption "故障排除工具";
    };
    
    # === 高级工具选项 ===
    advanced = {
      scanning = lib.mkEnableOption "网络扫描工具";
      testing = lib.mkEnableOption "网络测试工具";
      automation = lib.mkEnableOption "网络自动化工具";
    };
  };

  imports = [
    ./basic.nix       # 基础网络工具
    ./monitoring.nix  # 监控工具
    ./debugging.nix   # 调试工具  
    ./advanced.nix    # 高级工具
  ];
}
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
