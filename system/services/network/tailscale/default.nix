{ config, lib, pkgs, ... }:

{
  options.mySystem.services.network.tailscale = {
    enable = lib.mkEnableOption "Tailscale VPN 服务";
    exitNode.enable = lib.mkEnableOption "作为 Tailscale 出口节点";
    subnet.enable = lib.mkEnableOption "Tailscale 子网路由";
  };

  imports = [
    ./core.nix
  ];
}
