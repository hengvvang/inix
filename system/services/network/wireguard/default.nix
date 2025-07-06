{ config, lib, pkgs, ... }:

{
  # WireGuard VPN 模块的完整选项定义
  options.mySystem.services.network.wireguard = {
    enable = lib.mkEnableOption "WireGuard VPN 基础支持";
    
    # === 服务器选项 ===
    server = {
      enable = lib.mkEnableOption "WireGuard 服务器模式";
      
      listenPort = lib.mkOption {
        type = lib.types.int;
        default = 51820;
        description = "WireGuard 监听端口";
      };
      
      interface = lib.mkOption {
        type = lib.types.str;
        default = "wg0";
        description = "WireGuard 接口名称";
      };
      
      subnet = lib.mkOption {
        type = lib.types.str;
        default = "10.100.0.0/24";
        description = "VPN 子网范围";
      };
    };
    
    # === 客户端选项 ===
    client = {
      enable = lib.mkEnableOption "WireGuard 客户端模式";
      
      profiles = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "客户端配置文件列表";
      };
    };
    
    # === 网络选项 ===
    network = {
      ipForwarding = lib.mkEnableOption "IP 转发功能" // { default = true; };
      
      natMasquerade = lib.mkEnableOption "NAT 伪装功能";
      
      firewallBypass = lib.mkEnableOption "防火墙直通";
    };
    
    # === 安全选项 ===
    security = {
      keyRotation = lib.mkEnableOption "密钥轮换";
      
      peerIsolation = lib.mkEnableOption "对等点隔离";
      
      logging = lib.mkEnableOption "详细日志记录";
    };
  };

  imports = [
    ./server.nix     # 服务器功能
    ./client.nix     # 客户端功能  
    ./network.nix    # 网络配置
    ./security.nix   # 安全配置
  ];
}
