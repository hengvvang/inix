{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware.nix  # 使用 laptop 的硬件配置
      ../../system
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  # 系统级应用配置
  mySystem.pkgs = {
    enable = true;
    apps = {
      enable = true;
      shells.enable = true;
      terminals.enable = true;
      develop.enable = true;
      browsers.enable = true;
      communication.enable = true;
      media.enable = true;
      office.enable = true;
      gaming.enable = true;
      network.enable = true;
    };
  };

  # 启用 fish shell 程序
  programs.fish.enable = true;

  users.users.hengvvang = {
    isNormalUser = true;
    description = "hengvvang";
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak"];
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };
  
  users.users.zlritsu = {
    isNormalUser = true;
    description = "zlritsu";
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak"];
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };

  # 系统模块配置 - 日常使用主机配置
  mySystem = {
    # 桌面环境配置
    desktop = {
      enable = true;                   # 启用桌面环境模块
      preset = "gnome";                # 使用 GNOME 桌面环境
    };
    
    # 本地化配置
    locale = {
      enable = true;                   # 启用本地化模块
      timeZone = {
        enable = true;                 # 启用时区配置
        preset = "shanghai";           # 使用上海时区
      };
      inputMethod = {
        enable = true;                 # 启用输入法配置
        fcitx5.enable = true;          # 使用 fcitx5 输入法
      };
    };
    
    # 服务配置
    services = {
      enable = true;                   # 启用服务模块
      
      # 容器服务配置
      containers = {
        enable = true;                 # 启用容器服务模块
        
        # Docker 容器服务配置
        docker = {
          enable = true;               # 启用 Docker 服务
          compose = true;              # 启用 Docker Compose
          monitoring = true;           # 启用容器监控工具
          rootless = false;            # 使用标准 Docker 模式
          nvidia = false;              # 暂不启用 NVIDIA GPU 支持
          registry = {
            enable = false;            # 暂不启用本地 Registry
            port = 5000;              # Registry 端口
          };
        };
        
        # Flatpak 容器服务配置
        flatpak = {
          enable = true;               # 启用 Flatpak 服务
          flathub = true;              # 启用 Flathub 仓库
          fonts = true;                # 启用字体支持
          themes = true;               # 启用主题支持
          xdgPortal = true;            # 启用 XDG 门户支持
        };
      };
      
      network = {
        enable = true;                 # 启用网络服务
        
        # 网络管理器配置
        manager = {
          enable = true;               # 启用网络管理器
          hostname = "daily";          # 系统主机名
          preset = "networkmanager";   # 使用 NetworkManager
          tools = {
            enable = true;             # 启用网络诊断工具
            gui = true;                # 启用图形化管理工具
          };
        };
        
        # SSH 服务配置
        ssh = {
          enable = true;               # 启用 SSH 服务
          server = {
            enable = true;             # 启用 SSH 服务端
            port = 22;                 # SSH 端口
            passwordAuth = false;      # 禁用密码认证，仅使用密钥认证
          };
          client = {
            enable = true;             # 启用 SSH 客户端工具
          };
        };
      };
    };
  };

  # 此配置文件生成的系统版本，切勿更改
  system.stateVersion = "25.05";
}
