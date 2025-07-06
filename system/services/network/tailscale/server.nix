{ config, lib, pkgs, ... }:

{
  # Tailscale 服务器功能实现
  config = lib.mkMerge [
    # 出口节点配置
    (lib.mkIf (config.mySystem.services.network.tailscale.enable && config.mySystem.services.network.tailscale.mode.exitNode) {
      services.tailscale = {
        useRoutingFeatures = "server";
        extraUpFlags = [
          "--advertise-exit-node"
        ];
      };
      
      # 启用 IP 转发
      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = lib.mkIf config.mySystem.services.network.tailscale.network.ipv6 1;
      };
      
      # 防火墙配置
      networking.firewall = {
        checkReversePath = "loose";
        trustedInterfaces = [ "tailscale0" ];
      };
    })
    
    # 子网路由模式
    (lib.mkIf (config.mySystem.services.network.tailscale.enable && config.mySystem.services.network.tailscale.mode.subnet) {
      services.tailscale = {
        useRoutingFeatures = "server";
        extraUpFlags = [
          "--advertise-routes=192.168.0.0/24"  # 可配置
        ];
      };
      
      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
      };
    })
    
    # 中继节点模式
    (lib.mkIf (config.mySystem.services.network.tailscale.enable && config.mySystem.services.network.tailscale.mode.relay) {
      services.tailscale = {
        extraUpFlags = [
          "--advertise-connector"
        ];
      };
    })
  ];
}
