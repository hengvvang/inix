{ config, lib, pkgs, ... }:

{
  options.mySystem.services.network = {
    # SSH 远程访问
    ssh = {
      enable = lib.mkEnableOption "SSH 远程访问服务";
      passwordAuth = lib.mkEnableOption "SSH 密码认证";
      keyAuth = lib.mkEnableOption "SSH 密钥认证增强";
      hardening = lib.mkEnableOption "SSH 安全加固配置";
    };
    
    # VPN 服务
    vpn = {
      tailscale = {
        enable = lib.mkEnableOption "Tailscale VPN 服务";
        exitNode = lib.mkEnableOption "作为 Tailscale 出口节点";
        subnet = lib.mkEnableOption "Tailscale 子网路由";
        magicDNS = lib.mkEnableOption "Tailscale MagicDNS";
      };
      wireguard = {
        enable = lib.mkEnableOption "WireGuard VPN 客户端";
        server = lib.mkEnableOption "WireGuard VPN 服务器";
      };
    };
    
    # 网络工具
    tools = {
      enable = lib.mkEnableOption "网络诊断和监控工具";
      monitoring = lib.mkEnableOption "网络监控工具";
      security = lib.mkEnableOption "网络安全工具";
    };
  };

  imports = [
    ./ssh
    ./tailscale.nix
    ./wireguard.nix
    ./tools.nix
  ];
}
