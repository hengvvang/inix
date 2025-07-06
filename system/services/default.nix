{ config, lib, pkgs, ... }:

{
  options.mySystem.services = {
    # 容器和虚拟化服务
    docker = {
      enable = lib.mkEnableOption "Docker 容器服务" // { default = false; };
      compose.enable = lib.mkEnableOption "Docker Compose 支持" // { default = false; };
      buildkit.enable = lib.mkEnableOption "Docker Buildkit 构建器" // { default = false; };
      registry.enable = lib.mkEnableOption "本地 Docker Registry" // { default = false; };
      monitoring.enable = lib.mkEnableOption "Docker 监控和日志" // { default = false; };
      security.enable = lib.mkEnableOption "Docker 安全增强配置" // { default = false; };
    };
    
    # 网络服务
    network = {
      tailscale = {
        enable = lib.mkEnableOption "Tailscale VPN 服务" // { default = false; };
        exitNode.enable = lib.mkEnableOption "作为 Tailscale 出口节点" // { default = false; };
        subnet.enable = lib.mkEnableOption "Tailscale 子网路由" // { default = false; };
      };
      wireguard = {
        enable = lib.mkEnableOption "WireGuard VPN 服务" // { default = false; };
        peers.enable = lib.mkEnableOption "WireGuard 对等连接" // { default = false; };
      };
      ssh = {
        enable = lib.mkEnableOption "SSH 远程访问服务" // { default = false; };
        passwordAuth = lib.mkEnableOption "SSH 密码认证" // { default = false; };
      };
      tools.enable = lib.mkEnableOption "网络工具包" // { default = false; };
    };
    
    # 媒体服务
    media = {
      players.enable = lib.mkEnableOption "媒体播放器" // { default = false; };
      editing.enable = lib.mkEnableOption "媒体编辑工具" // { default = false; };
      streaming.enable = lib.mkEnableOption "流媒体工具" // { default = false; };
      download.enable = lib.mkEnableOption "下载工具" // { default = false; };
    };
    
    # 同步和备份服务
    sync = {
      syncthing.enable = lib.mkEnableOption "Syncthing 文件同步服务" // { default = false; };
      cloud.enable = lib.mkEnableOption "云存储同步工具" // { default = false; };
      backup.enable = lib.mkEnableOption "备份工具" // { default = false; };
    };
    
    # 硬件和系统服务
    hardware = {
      printing.enable = lib.mkEnableOption "CUPS 打印服务" // { default = false; };
      bluetooth.enable = lib.mkEnableOption "蓝牙服务" // { default = false; };
      sound.enable = lib.mkEnableOption "PipeWire 音频服务" // { default = false; };
    };
  };

  imports = [
    # 模块化服务目录
    ./docker
    ./network
    ./media
    ./sync
    ./hardware
  ];
}
