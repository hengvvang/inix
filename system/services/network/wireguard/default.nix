{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.network.wireguard.enable {
    # WireGuard VPN 服务 - 原子化配置
    environment.systemPackages = with pkgs; [
      wireguard-tools
      wireguard-go
    ];
    
    # 启用内核模块
    boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];
    
    # 网络配置
    networking.firewall.allowedUDPPorts = [ 51820 ];
    
    # IP 转发（如果启用对等连接）
    boot.kernel.sysctl = lib.mkIf config.mySystem.services.network.wireguard.peers.enable {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
  };
}
