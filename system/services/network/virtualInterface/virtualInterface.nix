{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.network.virtualInterface;
in
{
  config = lib.mkIf cfg.enable {
    # === 内核模块配置 ===
    boot.kernelModules = []
      ++ lib.optionals cfg.tun [ "tun" ]
      ++ lib.optionals cfg.tap [ "tap" ];
    
    # === 系统内核参数 ===
    boot.kernel.sysctl = lib.mkMerge [
      (lib.mkIf cfg.forwarding.ipv4 {
        "net.ipv4.ip_forward" = 1;
      })
      (lib.mkIf cfg.forwarding.ipv6 {
        "net.ipv6.conf.all.forwarding" = 1;
      })
    ];
    
    # === 用户组配置 ===
    users.groups.tun = {};
    
    # === udev 规则配置 ===
    services.udev.extraRules = lib.mkMerge [
      (lib.mkIf cfg.tun ''
        # TUN 设备权限
        KERNEL=="tun", GROUP="tun", MODE="0666"
        SUBSYSTEM=="misc", KERNEL=="tun", GROUP="tun", MODE="0666"
      '')
      (lib.mkIf cfg.tap ''
        # TAP 设备权限
        KERNEL=="tap[0-9]*", GROUP="tun", MODE="0666"
      '')
    ];
    
    # === 基础工具包 ===
    environment.systemPackages = with pkgs; []
      ++ lib.optionals cfg.tools.basic [
        iproute2     # ip 命令
        iptables     # iptables 防火墙规则
      ]
      ++ lib.optionals cfg.tools.bridge [
        bridge-utils # 网桥工具
      ];
    
    # === 防火墙规则 ===
    networking.firewall.extraCommands = lib.mkMerge [
      (lib.mkIf cfg.tun ''
        # 允许 TUN 接口流量
        iptables -I INPUT -i tun+ -j ACCEPT
        iptables -I FORWARD -i tun+ -j ACCEPT
        iptables -I FORWARD -o tun+ -j ACCEPT
      '')
      (lib.mkIf cfg.tap ''
        # 允许 TAP 接口流量
        iptables -I INPUT -i tap+ -j ACCEPT
        iptables -I FORWARD -i tap+ -j ACCEPT
        iptables -I FORWARD -o tap+ -j ACCEPT
      '')
    ];
  };
}
