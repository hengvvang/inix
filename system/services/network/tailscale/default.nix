{ config, lib, pkgs, ... }:

{
  # Tailscale VPN 模块的选项定义
  options.mySystem.services.network.tailscale = {
    enable = lib.mkEnableOption "Tailscale VPN 基础支持";
    
    # === 连接模式选项 ===
    mode = {
      client = lib.mkEnableOption "客户端模式" // { default = true; };
      exitNode = lib.mkEnableOption "作为出口节点";
      subnet = lib.mkEnableOption "子网路由模式";
      relay = lib.mkEnableOption "中继节点模式";
    };
    
    # === 网络配置选项 ===
    network = {
      openFirewall = lib.mkEnableOption "自动打开防火墙端口" // { default = true; };
      ipv6 = lib.mkEnableOption "IPv6 支持";
      magicDNS = lib.mkEnableOption "Magic DNS 功能" // { default = true; };
      funnel = lib.mkEnableOption "Tailscale Funnel 功能";
    };
    
    # === 安全选项 ===
    security = {
      keyExpiry = lib.mkOption {
        type = lib.types.str;
        default = "180d";
        description = "密钥过期时间";
      };
      acceptRoutes = lib.mkEnableOption "接受路由广播";
      acceptDNS = lib.mkEnableOption "接受 DNS 配置";
    };
    
    # === 高级选项 ===
    advanced = {
      loginServer = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "自定义登录服务器";
      };
      extraUpFlags = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "额外的启动参数";
      };
    };
  };

  imports = [
    # === 模块化导入：每个功能独立文件 ===
    ./client.nix      # 客户端配置
    ./server.nix      # 服务器配置
    ./network.nix     # 网络配置
    ./security.nix    # 安全配置
  ];
}
