{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # 基础 Tailscale 服务
    (lib.mkIf config.mySystem.services.network.vpn.tailscale.enable {
      services.tailscale = {
        enable = true;
        openFirewall = true;
        useRoutingFeatures = "client";
      };

      environment.systemPackages = with pkgs; [
        tailscale
      ];

      networking.firewall.trustedInterfaces = [ "tailscale0" ];
    })

    # 出口节点配置
    (lib.mkIf (config.mySystem.services.network.vpn.tailscale.enable && config.mySystem.services.network.vpn.tailscale.exitNode) {
      services.tailscale.useRoutingFeatures = lib.mkForce "both";
      networking.firewall.checkReversePath = "loose";
      
      # IP 转发
      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = 1;
      };
    })

    # 子网路由配置
    (lib.mkIf (config.mySystem.services.network.vpn.tailscale.enable && config.mySystem.services.network.vpn.tailscale.subnet) {
      services.tailscale.useRoutingFeatures = lib.mkForce "both";
    })

    # MagicDNS 配置
    (lib.mkIf (config.mySystem.services.network.vpn.tailscale.enable && config.mySystem.services.network.vpn.tailscale.magicDNS) {
      services.tailscale.extraUpFlags = [
        "--accept-dns=true"
      ];
    })
  ];
}