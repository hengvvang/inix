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
    
    # Web 服务
    web = {
      nginx = {
        enable = lib.mkEnableOption "Nginx Web 服务器" // { default = false; };
        ssl.enable = lib.mkEnableOption "Nginx SSL/TLS 支持" // { default = false; };
        cache.enable = lib.mkEnableOption "Nginx 缓存配置" // { default = false; };
        security.enable = lib.mkEnableOption "Nginx 安全增强" // { default = false; };
      };
    };
    
    # 网络服务
    network = {
      tailscale.enable = lib.mkEnableOption "Tailscale VPN 服务" // { default = false; };
      ssh.enable = lib.mkEnableOption "SSH 服务配置" // { default = false; };
    };
    
    # 媒体服务
    media = {
      jellyfin.enable = lib.mkEnableOption "Jellyfin 媒体服务器" // { default = false; };
      transmission.enable = lib.mkEnableOption "Transmission BitTorrent 客户端" // { default = false; };
    };
    
    # 存储和文件共享服务
    storage = {
      samba.enable = lib.mkEnableOption "Samba 文件共享服务" // { default = false; };
      nfs.enable = lib.mkEnableOption "NFS 网络文件系统" // { default = false; };
      syncthing.enable = lib.mkEnableOption "Syncthing 文件同步服务" // { default = false; };
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
    ./web
    ./network
    ./media
    ./storage
    ./hardware
    
    # 单文件服务
    ./ssh.nix
  ];
}
