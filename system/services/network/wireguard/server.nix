{ config, lib, pkgs, ... }:

{
  # WireGuard 服务器功能实现
  config = lib.mkIf (config.mySystem.services.network.wireguard.enable && config.mySystem.services.network.wireguard.server.enable) {
    # 基础 WireGuard 包
    environment.systemPackages = with pkgs; [
      wireguard-tools
      wireguard-go
      qrencode  # 生成二维码配置
    ];
    
    # 内核模块
    boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];
    
    # WireGuard 接口配置
    networking.wireguard.interfaces."${config.mySystem.services.network.wireguard.server.interface}" = {
      # 服务器监听端口
      listenPort = config.mySystem.services.network.wireguard.server.listenPort;
      
      # 服务器 IP 地址 (从子网中取第一个)
      ips = [ 
        (builtins.replaceStrings ["/24"] ["/32"] 
          (builtins.replaceStrings ["0.0/24"] ["0.1/32"] 
            config.mySystem.services.network.wireguard.server.subnet))
      ];
      
      # 生成密钥的脚本
      generatePrivateKeyFile = true;
      privateKeyFile = "/var/lib/wireguard/${config.mySystem.services.network.wireguard.server.interface}.key";
      
      # 对等点配置示例 (需要手动配置)
      peers = [
        # {
        #   # 客户端公钥
        #   publicKey = "客户端公钥";
        #   # 允许的 IP 范围
        #   allowedIPs = [ "10.100.0.2/32" ];
        # }
      ];
    };
    
    # 防火墙配置
    networking.firewall = {
      allowedUDPPorts = [ config.mySystem.services.network.wireguard.server.listenPort ];
      trustedInterfaces = [ config.mySystem.services.network.wireguard.server.interface ];
    };
  };
}
