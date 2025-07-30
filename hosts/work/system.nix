{ config, lib, pkgs, ... }:

{
  # 系统模块配置 - 工作主机配置
  mySystem = {
    # 系统级应用配置
    pkgs = {
      enable = true;
      apps.enable = true;
      toolkits.enable = true;
    };
    
    # 桌面环境配置
    desktop = {
      enable = true;                   # 启用桌面环境模块
      preset = "plasma";               # 使用 KDE Plasma 桌面环境
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
      
      # 容器服务配置 - 工作环境禁用
      containers = {
        enable = false;                # 🔴 禁用容器服务模块 (工作环境)
        
        # Docker 容器服务配置 - 禁用
        docker = {
          enable = false;              # 🔴 禁用 Docker 服务
          compose = false;             # 禁用 Docker Compose
          monitoring = false;          # 禁用容器监控工具
          rootless = false;            # 不使用 Rootless 模式
          nvidia = false;              # 不启用 NVIDIA GPU 支持
          registry = {
            enable = false;            # 不启用本地 Registry
            port = 5000;              # Registry 端口
          };
        };
        
        # Flatpak 容器服务配置 - 禁用
        flatpak = {
          enable = false;              # 🔴 禁用 Flatpak 服务
          flathub = false;             # 禁用 Flathub 仓库
          fonts = false;               # 禁用字体支持
          themes = false;              # 禁用主题支持
          xdgPortal = false;           # 禁用 XDG 门户支持
        };
      };
      
      network = {
        enable = true;                 # 启用网络服务
        
        # 网络管理器配置
        manager = {
          enable = true;               # 启用网络管理器
          hostname = "work";           # 系统主机名
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
}
