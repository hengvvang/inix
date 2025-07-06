{ config, lib, pkgs, ... }:

{
  options.mySystem.services.network = {
    enable = lib.mkEnableOption "网络服务";
    tailscale = {
      enable = lib.mkEnableOption "Tailscale VPN 服务";
      exitNode.enable = lib.mkEnableOption "作为 Tailscale 出口节点";
      subnet.enable = lib.mkEnableOption "Tailscale 子网路由";
    };
    wireguard = {
      enable = lib.mkEnableOption "WireGuard VPN 服务";
      peers.enable = lib.mkEnableOption "WireGuard 对等连接";
    };
    ssh = {
      enable = lib.mkEnableOption "SSH 远程访问服务";
      passwordAuth = lib.mkEnableOption "SSH 密码认证";
      keyAuth = lib.mkEnableOption "SSH 密钥认证增强";
      hardening = lib.mkEnableOption "SSH 安全加固配置";
    };
    tools = {
      enable = lib.mkEnableOption "网络工具包";
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
