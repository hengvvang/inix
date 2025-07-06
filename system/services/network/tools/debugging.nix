{ config, lib, pkgs, ... }:

{
  # 网络调试工具实现
  config = lib.mkMerge [
    # 数据包分析工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.debugging.packet) {
      environment.systemPackages = with pkgs; [
        # 包捕获和分析
        wireshark
        tshark
        tcpdump
        
        # 包生成和注入
        hping
        nemesis
        
        # 协议分析
        ngrep
        tcpflow
      ];
    })
    
    # 网络追踪工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.debugging.trace) {
      environment.systemPackages = with pkgs; [
        # 路由追踪
        traceroute
        mtr
        
        # 网络路径分析
        pathping
        
        # 连接追踪
        conntrack-tools
      ];
    })
    
    # 故障排除工具
    (lib.mkIf (config.mySystem.services.network.tools.enable && config.mySystem.services.network.tools.debugging.troubleshoot) {
      environment.systemPackages = with pkgs; [
        # 连接测试
        telnet
        netcat-gnu
        
        # DNS 诊断
        dig
        nslookup
        
        # 网络状态
        ss
        lsof
        
        # 防火墙调试
        iptables
        nftables
      ];
    })
  ];
}
