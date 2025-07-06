{ config, lib, pkgs, ... }:

{
  # Tailscale 网络功能实现
  config = lib.mkMerge [
    # IPv6 支持
    (lib.mkIf (config.mySystem.services.network.tailscale.enable && config.mySystem.services.network.tailscale.network.ipv6) {
      services.tailscale.extraUpFlags = [
        "--accept-ipv6"
      ];
      
      networking.enableIPv6 = true;
    })
    
    # Magic DNS 功能
    (lib.mkIf (config.mySystem.services.network.tailscale.enable && config.mySystem.services.network.tailscale.network.magicDNS) {
      services.tailscale.extraUpFlags = [
        "--accept-dns=true"
      ];
    })
    
    # Tailscale Funnel 功能
    (lib.mkIf (config.mySystem.services.network.tailscale.enable && config.mySystem.services.network.tailscale.network.funnel) {
      # Funnel 需要额外配置
      environment.systemPackages = with pkgs; [
        tailscale
      ];
      
      # 开放额外端口用于 Funnel
      networking.firewall.allowedTCPPorts = [ 443 80 ];
    })
    
    # 自定义防火墙配置
    (lib.mkIf (config.mySystem.services.network.tailscale.enable && config.mySystem.services.network.tailscale.network.openFirewall) {
      networking.firewall = {
        # Tailscale 默认端口
        allowedUDPPorts = [ 41641 ];
        trustedInterfaces = [ "tailscale0" ];
        
        # 允许 Tailscale 流量
        extraCommands = ''
          iptables -A INPUT -i tailscale0 -j ACCEPT
          iptables -A OUTPUT -o tailscale0 -j ACCEPT
        '';
      };
    })
  ];
}
