{ config, lib, pkgs, ... }:

{
  # 系统模块入口 - 仅做导入，类似 home/default.nix
  imports = [
    ./desktop
    ./users
    ./packages
    ./localization
    ./services
  ];

  # 所有系统模块的默认配置 - 在主机配置中按需启用
  mySystem = {
    # 桌面环境模块
    desktop.cosmic.enable = lib.mkDefault false;
    
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
        compose.enable = lib.mkDefault false;
        buildkit.enable = lib.mkDefault false;
        registry.enable = lib.mkDefault false;
        monitoring.enable = lib.mkDefault false;
        security.enable = lib.mkDefault false;
      };
      
      # 网络服务
      network = {
        enable = lib.mkDefault false;
        ssh = {
          enable = lib.mkDefault false;
          passwordAuth = lib.mkDefault false;
        };
        tailscale = {
          enable = lib.mkDefault false;
          exitNode.enable = lib.mkDefault false;
          subnet.enable = lib.mkDefault false;
        };
        wireguard = {
          enable = lib.mkDefault false;
          peers.enable = lib.mkDefault false;
        };
        tools.enable = lib.mkDefault false;
      };
      
      # 多媒体服务
      media = {
        enable = lib.mkDefault false;
        players.enable = lib.mkDefault false;
        editing.enable = lib.mkDefault false;
        streaming.enable = lib.mkDefault false;
        download.enable = lib.mkDefault false;
      };
      
      # 同步和备份服务
      sync = {
        enable = lib.mkDefault false;
        syncthing.enable = lib.mkDefault false;
        cloud.enable = lib.mkDefault false;
        backup.enable = lib.mkDefault false;
      };
      
      # === 原子化硬件驱动服务（已从hardware迁移） ===
      drivers = {
        enable = lib.mkDefault false;
        
        # 显卡驱动 - 原子化
        nvidia = {
          enable = lib.mkDefault false;
          openSource = lib.mkDefault false;
          powerManagement = lib.mkDefault false;
          settings = lib.mkDefault false;
        };
        amd.enable = lib.mkDefault false;
        intel.enable = lib.mkDefault false;
        
        # 输入设备驱动 - 原子化
        touchpad.enable = lib.mkDefault false;
        wacom.enable = lib.mkDefault false;
        
        # 网络驱动 - 原子化
        wifi.enable = lib.mkDefault false;
        bluetooth.enable = lib.mkDefault false;
        ethernet.enable = lib.mkDefault false;
        
        # 存储驱动 - 原子化
        ssd.enable = lib.mkDefault false;
        usb.enable = lib.mkDefault false;
        
        # 从hardware迁移的驱动 - 原子化
        audio.enable = lib.mkDefault false;
        printing.enable = lib.mkDefault false;
      };
    };
  };
}
