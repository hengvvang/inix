{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.network.tailscale.enable && config.mySystem.services.network.tailscale.mode.client) {
    # Tailscale 客户端基础配置
    services.tailscale = {
      enable = true;
      openFirewall = config.mySystem.services.network.tailscale.network.openFirewall;
      useRoutingFeatures = "client";
      
      # 基础客户端参数
      extraUpFlags = [
        "--accept-dns=${if config.mySystem.services.network.tailscale.security.acceptDNS then "true" else "false"}"
        "--accept-routes=${if config.mySystem.services.network.tailscale.security.acceptRoutes then "true" else "false"}"
      ] ++ config.mySystem.services.network.tailscale.advanced.extraUpFlags;
    };

    # 客户端工具
    environment.systemPackages = with pkgs; [
      tailscale
    ];

    # 客户端专用防火墙配置
    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}
