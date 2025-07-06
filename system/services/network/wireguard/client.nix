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
    
    # WireGuard 客户端工具
    environment.systemPackages = with pkgs; [
      wireguard-tools
    ];
  };
}
