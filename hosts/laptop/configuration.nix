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
        enable = true;                    # 启用网络服务
        # SSH 服务 - 远程访问
        ssh = {
          enable = true;                  # 启用 SSH 服务
          passwordAuth = true;            # 允许密码认证
        };
        
        # VPN 服务
        tailscale = {
          enable = true;                  # 启用 Tailscale VPN
          # exitNode.enable = true;       # 可选：作为出口节点
          # subnet.enable = true;         # 可选：子网路由
        };
        # wireguard.enable = true;        # 可选：WireGuard VPN
        
        # 网络工具
        tools.enable = true;              # 基础网络工具
      };
      
      # 多媒体服务
      media = {
        enable = true;                    # 启用媒体服务
        # 媒体播放器
        players.enable = true;            # 启用多媒体播放器
        
        # 其他媒体功能可按需启用
        # editing.enable = true;          # 媒体编辑工具
        # streaming.enable = true;        # 流媒体工具
        # download.enable = true;         # 下载工具
      };
      
      # 同步和备份服务
      sync = {
        enable = true;                    # 启用同步服务
        # 文件同步
        syncthing.enable = true;          # 启用 Syncthing
        
        # 云存储同步（按需启用）
        # cloud.enable = true;            # Rclone 多云同步
        
        # 备份服务（按需启用）
        # backup.enable = true;           # 备份工具
      };
      
      # 硬件服务
      hardware = {
        enable = true;                    # 启用硬件服务
        sound.enable = true;              # PipeWire 音频
        bluetooth.enable = true;          # 蓝牙支持
        # printing.enable = true;         # 可选：打印服务
      };
      
      # 硬件驱动服务
      drivers = {
        enable = true;                    # 启用驱动服务
        graphics = {
          enable = true;                  # 启用显卡驱动
          nvidia = {
            enable = true;                # NVIDIA 显卡驱动
            powerManagement = true;       # 电源管理
            settings = true;              # 设置工具
          };
        };
        input = {
          enable = true;                  # 启用输入设备
          touchpad.enable = true;         # 触摸板支持
        };
        network = {
          enable = true;                  # 启用网络驱动
          wifi.enable = true;             # WiFi 驱动
          bluetooth.enable = true;        # 蓝牙驱动
        };
        storage = {
          enable = true;                  # 启用存储驱动
          ssd.enable = true;              # SSD 优化
          usb.enable = true;              # USB 设备支持
        };
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

