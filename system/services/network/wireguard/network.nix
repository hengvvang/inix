{ config, lib, pkgs, ... }:

{
  # WireGuard 网络功能实现
  config = lib.mkMerge [
    # IP 转发功能
    (lib.mkIf (config.mySystem.services.network.wireguard.enable && config.mySystem.services.network.wireguard.network.ipForwarding) {
      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = 1;
        "net.ipv4.conf.all.proxy_arp" = 1;
      };
    })
    
    # NAT 伪装功能
    (lib.mkIf (config.mySystem.services.network.wireguard.enable && config.mySystem.services.network.wireguard.network.natMasquerade) {
      networking.nat = {
        enable = true;
        externalInterface = "eth0";  # 可配置
        internalInterfaces = [ 
          config.mySystem.services.network.wireguard.server.interface 
        ];
      };
      
      # iptables NAT 规则
      networking.firewall.extraCommands = ''
        # WireGuard NAT 规则
        iptables -t nat -A POSTROUTING -s ${config.mySystem.services.network.wireguard.server.subnet} -o eth0 -j MASQUERADE
        iptables -A FORWARD -i ${config.mySystem.services.network.wireguard.server.interface} -j ACCEPT
        iptables -A FORWARD -o ${config.mySystem.services.network.wireguard.server.interface} -j ACCEPT
      '';
    })
    
    # 防火墙直通
    (lib.mkIf (config.mySystem.services.network.wireguard.enable && config.mySystem.services.network.wireguard.network.firewallBypass) {
      networking.firewall = {
        trustedInterfaces = [
          config.mySystem.services.network.wireguard.server.interface
        ];
        
        # 允许 WireGuard 流量完全通过
        extraCommands = ''
          iptables -A INPUT -i ${config.mySystem.services.network.wireguard.server.interface} -j ACCEPT
          iptables -A OUTPUT -o ${config.mySystem.services.network.wireguard.server.interface} -j ACCEPT
        '';
      };
    })
  ];
}
