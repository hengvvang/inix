{ config, lib, pkgs, ... }:

{
  # WireGuard 安全功能实现
  config = lib.mkMerge [
    # 详细日志记录
    (lib.mkIf (config.mySystem.services.network.wireguard.enable && config.mySystem.services.network.wireguard.security.logging) {
      # 启用 WireGuard 详细日志
      boot.kernel.sysctl = {
        "net.core.rmem_default" = 262144;
        "net.core.rmem_max" = 16777216;
        "net.core.wmem_default" = 262144;
        "net.core.wmem_max" = 16777216;
      };
      
      # 日志监控工具
      environment.systemPackages = with pkgs; [
        wireguard-tools
        tcpdump
        wireshark-cli
      ];
    })
    
    # 密钥轮换支持
    (lib.mkIf (config.mySystem.services.network.wireguard.enable && config.mySystem.services.network.wireguard.security.keyRotation) {
      # 密钥轮换支持
      systemd.tmpfiles.rules = [
        "d /var/lib/wireguard 0700 root root -"
      ];
      
      # 定期密钥轮换 (可选)
      systemd.timers.wireguard-key-rotation = {
        description = "WireGuard 密钥轮换定时器";
        timerConfig = {
          OnCalendar = "monthly";  # 每月轮换
          Persistent = true;
        };
      };
      
      systemd.services.wireguard-key-rotation = {
        description = "WireGuard 密钥轮换服务";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.bash}/bin/bash -c 'wg-rotate-keys'";
        };
      };
    })
    
    # 对等点隔离
    (lib.mkIf (config.mySystem.services.network.wireguard.enable && config.mySystem.services.network.wireguard.security.peerIsolation) {
      # 防火墙规则阻止对等点互相通信
      networking.firewall.extraCommands = ''
        # 阻止 WireGuard 客户端之间的通信
        iptables -A FORWARD -i ${config.mySystem.services.network.wireguard.server.interface} -o ${config.mySystem.services.network.wireguard.server.interface} -j DROP
      '';
    })
  ];
}
