{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # WireGuard 客户端
    (lib.mkIf config.mySystem.services.network.vpn.wireguard.enable {
      environment.systemPackages = with pkgs; [
        wireguard-tools
        wireguard-go
      ];
      
      # 启用内核模块
      boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];
      
      # 网络配置
      networking.firewall.allowedUDPPorts = [ 51820 ];
    })

    # WireGuard 服务器
    (lib.mkIf (config.mySystem.services.network.vpn.wireguard.enable && config.mySystem.services.network.vpn.wireguard.server) {
      # IP 转发
      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = 1;
      };
      
      # 创建示例配置目录
      systemd.tmpfiles.rules = [
        "d /etc/wireguard 0700 root root -"
      ];
      
      # 管理工具和脚本
      environment.systemPackages = with pkgs; [
        wireguard-tools
        qrencode  # 生成 QR 码分享配置
        
        # 示例配置生成脚本
        (writeShellScriptBin "wg-setup" ''
          #!/usr/bin/env bash
          
          # 生成密钥对
          wg genkey | tee /etc/wireguard/server_private.key | wg pubkey > /etc/wireguard/server_public.key
          
          # 设置权限
          chmod 600 /etc/wireguard/server_private.key
          chmod 644 /etc/wireguard/server_public.key
          
          echo "WireGuard keys generated in /etc/wireguard/"
          echo "Edit /etc/wireguard/wg0.conf to configure your server"
        '')
      ];
    })
  ];
}
