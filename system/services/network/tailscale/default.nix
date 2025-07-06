{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.network.tailscale.enable {
    # Tailscale VPN 服务 - 原子化配置
    services.tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = 
        if config.mySystem.services.network.tailscale.exitNode.enable || config.mySystem.services.network.tailscale.subnet.enable
        then "both" 
        else "client";
      
      # 额外的启动参数
      extraUpFlags = 
        lib.optionals config.mySystem.services.network.tailscale.exitNode.enable [
          "--advertise-exit-node"
        ] ++ lib.optionals config.mySystem.services.network.tailscale.subnet.enable [
          "--advertise-routes=192.168.0.0/24"
        ];
    };

    # 网络配置
    networking.firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      checkReversePath = lib.mkIf config.mySystem.services.network.tailscale.exitNode.enable "loose";
    };

    # IP 转发配置
    boot.kernel.sysctl = lib.mkIf (config.mySystem.services.network.tailscale.exitNode.enable || config.mySystem.services.network.tailscale.subnet.enable) {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    # Tailscale 工具
    environment.systemPackages = with pkgs; [
      tailscale
    ];
  };
}
