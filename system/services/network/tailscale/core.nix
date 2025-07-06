{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.network.tailscale.enable {
    # Tailscale VPN 服务配置
    services.tailscale = {
      enable = true;
      openFirewall = true;
      
      # 根据配置选择路由功能
      useRoutingFeatures = 
        if config.mySystem.services.network.tailscale.subnet.enable then "both"
        else "client";
    };

    # 确保 Tailscale 包可用
    environment.systemPackages = with pkgs; [
      tailscale
    ];

    # 网络配置
    networking = {
      # 启用 IP 转发（如果作为出口节点）
      # firewall.checkReversePath = "loose";
      
      # 信任 Tailscale 接口
      firewall.trustedInterfaces = [ "tailscale0" ];
    };

    # 自动启动提示
    systemd.services.tailscale-autoconnect = {
      description = "Automatic connection to Tailscale";
      after = [ "network-pre.target" "tailscale.service" ];
      wants = [ "network-pre.target" "tailscale.service" ];
      wantedBy = [ "multi-user.target" ];
      
      serviceConfig = {
        Type = "oneshot";
      };
      
      script = ''
        # 等待 tailscale 服务启动
        sleep 2
        
        # 检查是否已经连接
        status=$(${pkgs.tailscale}/bin/tailscale status --json | ${pkgs.jq}/bin/jq -r '.BackendState')
        if [ "$status" = "Running" ]; then
          echo "Tailscale already connected"
          exit 0
        fi
        
        # 如果未连接，提示用户手动连接
        echo "Tailscale is not connected. Please run: sudo tailscale up"
      '';
    };

    # 出口节点配置
    networking.firewall.checkReversePath = lib.mkIf config.mySystem.services.network.tailscale.exitNode.enable "loose";
  };
}
