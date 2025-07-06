{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      # <home-manager/nixos>
      ../../system
    ];


  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hengvvang";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  

  nixpkgs.config.allowUnfree = true;

  # 系统模块配置 - 完全由主机决定启用哪些模块
  # 适合 laptop 主机：启用完整的桌面环境和所有功能
  mySystem = {
    desktop.cosmic.enable = true;       # 桌面环境 - laptop需要图形界面
    hardware.enable = true;             # 硬件配置 - 基础需求
    users.enable = true;                # 用户配置 - 必需
    packages.enable = true;             # 系统包 - 完整软件环境
    services = {
      # Docker 容器服务 - 完整功能
      docker = {
        enable = true;                    # 启用 Docker 核心服务
        compose.enable = true;            # 启用 Docker Compose
        buildkit.enable = true;           # 启用 Buildkit 构建器
        monitoring.enable = true;         # 启用监控（Portainer + cAdvisor）
        # registry.enable = true;         # 可选：本地 Registry
        # security.enable = true;         # 可选：安全增强
      };
      
      # 网络服务
      network = {
        # SSH 服务 - 远程访问
        ssh = {
          enable = true;                  # 启用 SSH 服务
          passwordAuth = true;            # 允许密码认证
          # keyAuth = true;               # 可选：密钥认证增强
          # hardening = true;             # 可选：安全加固
        };
        
        # VPN 服务
        vpn = {
          tailscale = {
            enable = true;                # 启用 Tailscale VPN
            # exitNode = true;            # 可选：作为出口节点
            # subnet = true;              # 可选：子网路由
            # magicDNS = true;            # 可选：MagicDNS
          };
          # wireguard.enable = true;      # 可选：WireGuard VPN
        };
        
        # 网络工具
        tools = {
          enable = true;                  # 基础网络工具
          # monitoring = true;            # 可选：网络监控工具
          # security = true;              # 可选：网络安全工具
        };
      };
      
      # 多媒体服务
      media = {
        # 音视频播放器
        players = {
          enable = true;                  # 启用多媒体播放器
          mpv = true;                     # MPV 增强配置
          vlc = true;                     # VLC 播放器
          # music = true;                 # 可选：音乐播放器
        };
        
        # 其他媒体功能可按需启用
        # editing.enable = true;          # 媒体编辑工具
        # streaming.jellyfin.enable = true; # Jellyfin 媒体服务器
        # download.enable = true;         # 下载工具
      };
      
      # 同步和备份服务
      sync = {
        # 文件同步
        syncthing = {
          enable = true;                  # 启用 Syncthing
          gui.enable = true;              # Web 管理界面
          discovery.enable = true;        # 全局发现
          # folders.enable = true;        # 可选：预配置文件夹
        };
        
        # 云存储同步（按需启用）
        # cloud.rclone.enable = true;     # Rclone 多云同步
        # cloud.dropbox.enable = true;    # Dropbox 客户端
        
        # 备份服务（按需启用）
        # backup.rsync.enable = true;     # Rsync 增量备份
        # backup.timeshift.enable = true; # 系统快照
      };
      
      # 硬件服务
      hardware = {
        sound.enable = true;              # PipeWire 音频
        bluetooth.enable = true;          # 蓝牙支持
        # printing.enable = true;         # 可选：打印服务
      };
    };
    
    # 本地化配置 - 支持细粒度控制
    localization = {
      # 时区选择 (只能选择一个)
      timeZone.shanghai.enable = true;  # 中国上海时区
      # timeZone.newYork.enable = true; # 美国纽约时区
      # timeZone.losAngeles.enable = true; # 美国洛杉矶时区
      
      # 输入法选择 (只能选择一个)
      inputMethod.fcitx5.enable = true; # 推荐：Fcitx5 (最新)
      # inputMethod.ibus.enable = true; # 备选：IBus
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;


  # nix.settings.substituters = lib.mkForce [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  #      				      "https://mirrors.ustc.edu.cn/nix-channels/store"
  # ];

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

