{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.ethernet;
in
{
  # 以太网驱动模块 - 合理分层版
  options.mySystem.services.drivers.ethernet = {
    enable = lib.mkEnableOption "以太网驱动支持";
    
    # 基础网络配置
    dhcp = lib.mkEnableOption "DHCP 自动配置" // { default = true; };
    optimization = lib.mkEnableOption "网络性能优化" // { default = false; };
    
    # 工具配置
    tools = {
      basic = lib.mkEnableOption "基础网络工具" // { default = true; };
      monitoring = lib.mkEnableOption "网络监控工具" // { default = false; };
    };
    
    # 高级功能（企业级功能，单独模块）
    advanced = {
      enable = lib.mkEnableOption "高级以太网功能";
      wakeonlan = lib.mkEnableOption "网络唤醒功能" // { default = false; };
      bonding = lib.mkEnableOption "网卡绑定支持" // { default = false; };
      vlan = lib.mkEnableOption "VLAN 支持" // { default = false; };
    };
  };

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
