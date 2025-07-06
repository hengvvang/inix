{ config, lib, pkgs, ... }:

{
  # 系统模块入口 - 仅做导入，类似 home/default.nix
  imports = [
    ./desktop
    ./hardware
    ./users
    ./packages
    ./localization
    ./services
  ];

  # 所有系统模块的默认配置 - 在主机配置中按需启用
  mySystem = {
    # 桌面环境模块
    desktop.cosmic.enable = lib.mkDefault false;
    
    # 硬件配置模块
    hardware.enable = lib.mkDefault false;
    
    # 用户配置模块
    users.enable = lib.mkDefault false;
    
    # 系统包模块
    packages.enable = lib.mkDefault false;
    
    # 本地化配置模块
    localization = {
      # 时区配置（只能选择一个）
      timeZone.shanghai.enable = lib.mkDefault false;
      timeZone.newYork.enable = lib.mkDefault false;
      timeZone.losAngeles.enable = lib.mkDefault false;
      
      # 输入法配置（只能选择一个）
      inputMethod.fcitx5.enable = lib.mkDefault false;
      inputMethod.ibus.enable = lib.mkDefault false;
    };
    
    # 服务配置模块
    services = {
      # Docker 容器服务
      docker = {
        enable = lib.mkDefault false;
        compose.enable = lib.mkDefault false;      # Docker Compose 支持
        buildkit.enable = lib.mkDefault false;     # 构建器增强
        registry.enable = lib.mkDefault false;     # 本地镜像仓库
        monitoring.enable = lib.mkDefault false;   # 监控工具
        security.enable = lib.mkDefault false;     # 安全增强
      };
      
      # Web 服务
      web.nginx = {
        enable = lib.mkDefault false;
        ssl.enable = lib.mkDefault false;          # SSL/TLS 支持
        cache.enable = lib.mkDefault false;        # 缓存配置
        security.enable = lib.mkDefault false;     # 安全增强
      };
      
      # 网络服务
      network = {
        tailscale.enable = lib.mkDefault false;    # VPN 服务
        ssh.enable = lib.mkDefault false;          # SSH 远程访问
      };
      
      # 媒体服务
      media = {
        jellyfin.enable = lib.mkDefault false;     # 媒体服务器
        transmission.enable = lib.mkDefault false; # BT 下载客户端
      };
      
      # 存储和文件共享服务
      storage = {
        samba.enable = lib.mkDefault false;        # Windows 文件共享
        nfs.enable = lib.mkDefault false;          # Unix/Linux 文件共享
        syncthing.enable = lib.mkDefault false;    # 点对点文件同步
      };
      
      # 硬件和系统服务
      hardware = {
        printing.enable = lib.mkDefault false;     # 打印和扫描
        bluetooth.enable = lib.mkDefault false;    # 蓝牙连接
        sound.enable = lib.mkDefault false;        # 音频系统
      };
    };
  };
}
