{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.ethernet;
in
{
  config = lib.mkIf cfg.enable {
    # 基础网络配置
    networking.useDHCP = cfg.dhcp;
    systemd.network.enable = true;
    
    # 内核模块
    boot.kernelModules = [ "8021q" ]  # VLAN 支持
      ++ lib.optionals (cfg.advanced.enable && cfg.advanced.bonding) [ "bonding" ];
    
    # 基础以太网工具
    environment.systemPackages = with pkgs; [
      ethtool           # 以太网工具
      mii-tool          # 媒体独立接口工具
    ] 
    # 基础工具
    ++ lib.optionals cfg.tools.basic [
      nettools          # 传统网络工具
      iproute2          # 现代网络工具
    ]
    # 监控工具
    ++ lib.optionals cfg.tools.monitoring [
      iftop             # 网络流量监控
      nethogs           # 进程网络使用监控
      iperf3            # 网络性能测试
    ]
    # WOL 工具
    ++ lib.optionals (cfg.advanced.enable && cfg.advanced.wakeonlan) [
      wakeonlan         # WOL 发送工具
    ]
    # 绑定工具
    ++ lib.optionals (cfg.advanced.enable && cfg.advanced.bonding) [
      ifenslave         # 绑定工具
    ];
    
    # 网络性能优化
    boot.kernel.sysctl = lib.mkIf cfg.optimization {
      "net.core.rmem_max" = 134217728;
      "net.core.wmem_max" = 134217728;
      "net.ipv4.tcp_rmem" = "4096 87380 134217728";
      "net.ipv4.tcp_wmem" = "4096 65536 134217728";
    };
  };
}
