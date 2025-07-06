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
    
    # 服务配置模块 - 专注个人电脑使用场景
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
      
      # 网络服务
      network = {
        # SSH 远程访问
        ssh = {
          enable = lib.mkDefault false;              # SSH 服务
          passwordAuth = lib.mkDefault false;        # 密码认证
          keyAuth = lib.mkDefault false;             # 密钥认证增强
          hardening = lib.mkDefault false;           # 安全加固
        };
        
        # VPN 服务
        vpn = {
          tailscale = {
            enable = lib.mkDefault false;            # Tailscale VPN
            exitNode = lib.mkDefault false;          # 出口节点
            subnet = lib.mkDefault false;            # 子网路由
            magicDNS = lib.mkDefault false;          # MagicDNS
          };
          wireguard = {
            enable = lib.mkDefault false;            # WireGuard 客户端
            server = lib.mkDefault false;            # WireGuard 服务器
          };
        };
        
        # 网络工具
        tools = {
          enable = lib.mkDefault false;              # 网络诊断工具
          monitoring = lib.mkDefault false;          # 网络监控
          security = lib.mkDefault false;            # 网络安全工具
        };
      };
      
      # 多媒体服务
      media = {
        # 音视频播放
        players = {
          enable = lib.mkDefault false;              # 多媒体播放器
          mpv = lib.mkDefault false;                 # MPV 增强配置
          vlc = lib.mkDefault false;                 # VLC 播放器
          music = lib.mkDefault false;               # 音乐播放器
        };
        
        # 媒体编辑
        editing = {
          enable = lib.mkDefault false;              # 媒体编辑工具
          video = lib.mkDefault false;               # 视频编辑
          audio = lib.mkDefault false;               # 音频编辑
          image = lib.mkDefault false;               # 图像编辑
        };
        
        # 流媒体服务 (个人使用)
        streaming = {
          jellyfin = {
            enable = lib.mkDefault false;            # Jellyfin 媒体服务器
            hardware = lib.mkDefault false;          # 硬件加速
            plugins = lib.mkDefault false;           # 常用插件
          };
          dlna = lib.mkDefault false;                # DLNA 媒体共享
        };
        
        # 下载工具
        download = {
          enable = lib.mkDefault false;              # 媒体下载工具
          youtube = lib.mkDefault false;             # YouTube 下载
          torrent = lib.mkDefault false;             # BT 客户端
          aria2 = lib.mkDefault false;               # Aria2 下载管理器
        };
      };
      
      # 同步和备份服务
      sync = {
        # 文件同步
        syncthing = {
          enable = lib.mkDefault false;              # Syncthing 服务
          gui.enable = lib.mkDefault false;          # Web 管理界面
          discovery.enable = lib.mkDefault false;    # 全局发现
          folders.enable = lib.mkDefault false;      # 预配置文件夹
        };
        
        # 云存储同步
        cloud = {
          enable = lib.mkDefault false;              # 云存储工具
          rclone.enable = lib.mkDefault false;       # Rclone 多云同步
          dropbox.enable = lib.mkDefault false;      # Dropbox 客户端
          onedrive.enable = lib.mkDefault false;     # OneDrive 同步
        };
        
        # 备份服务
        backup = {
          enable = lib.mkDefault false;              # 本地备份服务
          rsync.enable = lib.mkDefault false;        # Rsync 增量备份
          timeshift.enable = lib.mkDefault false;    # 系统快照
        };
      };
      
      # 硬件服务
      hardware = {
        printing.enable = lib.mkDefault false;       # 打印服务
        bluetooth.enable = lib.mkDefault false;      # 蓝牙支持
        sound.enable = lib.mkDefault false;          # 音频系统
      };
    };
  };
}
