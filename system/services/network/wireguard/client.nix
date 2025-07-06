{ config, lib, pkgs, ... }:

{
  # WireGuard 客户端功能实现
  config = lib.mkIf (config.mySystem.services.network.wireguard.enable && config.mySystem.services.network.wireguard.client.enable) {
    # 客户端工具
    environment.systemPackages = with pkgs; [
      wireguard-tools
      networkmanager-openvpn  # 网络管理器支持
    ];
    
    # 为每个配置文件创建接口
    networking.wireguard.interfaces = lib.listToAttrs (
      lib.imap0 (i: profile: {
        name = "wg-client-${toString i}";
        value = {
          # 配置文件路径
          configFile = "/etc/wireguard/${profile}.conf";
          
          # 自动启动
          autostart = false;  # 手动控制
        };
      }) config.mySystem.services.network.wireguard.client.profiles
    );
    
    # 客户端管理脚本
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "wg-client" ''
        #!/bin/bash
        case "$1" in
          up)
            if [ -z "$2" ]; then
              echo "用法: wg-client up <配置名>"
              exit 1
            fi
            wg-quick up "$2"
            ;;
          down)
            if [ -z "$2" ]; then
              echo "用法: wg-client down <配置名>"
              exit 1
            fi
            wg-quick down "$2"
            ;;
          status)
            wg show
            ;;
          list)
            ls -1 /etc/wireguard/*.conf 2>/dev/null | sed 's|/etc/wireguard/||g' | sed 's|\.conf||g'
            ;;
          *)
            echo "用法: wg-client {up|down|status|list} [配置名]"
            exit 1
            ;;
        esac
      '')
    ];
  };
}
