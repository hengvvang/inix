{ config, lib, pkgs, ... }:

{
  options.mySystem.services = {
    # 容器和虚拟化服务
    docker = {
      enable = lib.mkEnableOption "Docker 容器服务";
      compose.enable = lib.mkEnableOption "Docker Compose 支持";
      buildkit.enable = lib.mkEnableOption "Docker Buildkit 构建器";
      registry.enable = lib.mkEnableOption "本地 Docker Registry";
      monitoring.enable = lib.mkEnableOption "Docker 监控和日志";
      security.enable = lib.mkEnableOption "Docker 安全增强配置";
    };
    
    # 网络服务
    network = {
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
      };
      tools.enable = lib.mkEnableOption "网络工具包";
    };
    
    # 媒体服务
    media = {
      enable = lib.mkEnableOption "媒体服务";
      players.enable = lib.mkEnableOption "媒体播放器";
      editing.enable = lib.mkEnableOption "媒体编辑工具";
      streaming.enable = lib.mkEnableOption "流媒体工具";
      download.enable = lib.mkEnableOption "下载工具";
    };
    
    # 同步和备份服务
    sync = {
      enable = lib.mkEnableOption "同步和备份服务";
      syncthing.enable = lib.mkEnableOption "Syncthing 文件同步服务";
      cloud.enable = lib.mkEnableOption "云存储同步工具";
      backup.enable = lib.mkEnableOption "备份工具";
    };
    
    # 硬件和系统服务
    hardware = {
      enable = lib.mkEnableOption "硬件服务";
      printing.enable = lib.mkEnableOption "CUPS 打印服务";
      bluetooth.enable = lib.mkEnableOption "蓝牙服务";
      sound.enable = lib.mkEnableOption "PipeWire 音频服务";
    };
  };

  imports = [
    # 模块化服务目录
    ./docker
    ./network
    ./media
    ./sync
    ./hardware
    ./drivers
  ];
}
