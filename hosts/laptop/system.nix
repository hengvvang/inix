{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware.nix
      ../../system
      ../../pkgs/system.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

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

  # 系统模块配置 - 完全由主机决定启用哪些模块
  # 适合 laptop 主机：启用完整的桌面环境和所有功能
  mySystem = {
    # 桌面环境配置
    desktop = {
      enable = true;                   # 启用桌面环境模块
      preset = "cosmic";               # 使用 COSMIC 桌面环境
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
          enable = true;               # 🟢 启用网络管理器
          hostname = "laptop";         # 系统主机名
          preset = "networkmanager";
          tools = {
            enable = true;             # 启用网络诊断工具
            gui = true;                # 启用图形化管理工具
          };
        };
        
        # SSH 服务配置
        ssh = {
          enable = true;               # 🟢 启用 SSH 服务
          server = {
            enable = true;             # 启用 SSH 服务端
            port = 22;                 # SSH 端口
            passwordAuth = false;      # 禁用密码认证，仅使用密钥认证
          };
          client = {
            enable = true;             # 启用 SSH 客户端工具
          };
        };
        
        proxy = {
          enable = true;               # 启用代理服务模块
          
          # Clash 代理服务
          clash = {
            enable = false;            # 🔴 禁用 - 需要时设为 true
            tunMode = false;           # TUN 模式（启用时生效）
            webPort = 9090;           # Web UI 端口
            mixedPort = 7890;         # HTTP/SOCKS5 混合端口
            subscriptionUrl = "https://fba01.fbsubcn01.cc:2096/flydsubal/cymeoq8salu87n34?sub=2&extend=1";  # 🔴 替换为你的订阅链接
            autoStart = true;         # 系统启动时自动启动
            updateInterval = "daily"; # 订阅更新间隔
          };
          
          # V2Ray 代理服务
          v2ray = {
            enable = false;           # 🔴 禁用 - 需要时设为 true
            tunMode = false;          # TUN 模式透明代理
            httpPort = 8080;          # HTTP 代理端口
            socksPort = 1080;         # SOCKS5 代理端口
            tunPort = 10808;          # TUN 模式端口
            subscriptionUrl = "https://fba01.fbsubcn01.cc:2096/flydsubal/cymeoq8salu87n34?sub=2&extend=1";  # 🔴 替换为你的订阅链接
            autoStart = false;        # 手动启动（避免与其他代理冲突）
            updateInterval = "daily"; # 订阅更新间隔
          };
          
          # Xray 代理服务
          xray = {
            enable = false;           # 🔴 禁用 - 需要时设为 true
            tunMode = false;          # TUN 模式透明代理
            httpPort = 8081;          # HTTP 代理端口（避免冲突）
            socksPort = 1081;         # SOCKS5 代理端口（避免冲突）
            tunPort = 10809;          # TUN 模式端口（避免冲突）
            subscriptionUrl = "https://fba01.fbsubcn01.cc:2096/flydsubal/cymeoq8salu87n34?sub=2&extend=1";   # 🔴 替换为你的订阅链接
            autoStart = false;        # 手动启动（避免与其他代理冲突）
            updateInterval = "daily"; # 订阅更新间隔
          };
          
          # Shadowsocks 代理服务
          shadowsocks = {
            enable = false;           # 🔴 禁用 - 需要时设为 true
            localPort = 1082;         # 本地代理端口（避免冲突）
            subscriptionUrl = "https://your-shadowsocks-subscription-url";  # 🔴 替换为你的订阅链接
            autoStart = false;        # 手动启动（避免与其他代理冲突）
            updateInterval = "daily"; # 订阅更新间隔
          };
          
          # sing-box 代理服务 
          sing-box = {
            enable = false;           # 🔴 禁用 - 需要时设为 true
            tunMode = true;           # TUN 模式透明代理
            webPort = 9091;           # Web UI 端口（避免与 Clash 冲突）
            mixedPort = 7891;         # HTTP/SOCKS5 混合端口（避免与 Clash 冲突）
            subscriptionUrl = "https://fba01.fbsubcn01.cc:2096/flydsubal/cymeoq8salu87n34?sub=2&extend=1";  # 🔴 替换为你的订阅链接
            autoStart = false;        # 手动启动（避免与其他代理冲突）
            updateInterval = "daily"; # 订阅更新间隔
            logLevel = "info";        # 日志级别
          };
        };
      };
      
      # 媒体服务配置
      media = {
        enable = true;                 # 🟢 启用媒体服务
        video = {
          enable = true;               # 启用视频播放器
          mpv = true;                  # MPV 播放器
          vlc = false;                 # VLC 播放器
        };
        audio = {
          enable = true;               # 启用音频播放器
          spotify = true;              # Spotify（需要时启用）
          audacious = false;           # Audacious
        };
        codecs = {
          enable = true;               # 启用编解码器
          ffmpeg = true;               # FFmpeg
          gstreamer = false;           # GStreamer
        };
        streaming = {
          enable = true;               # 启用流媒体工具
          download = true;             # yt-dlp 下载工具
        };
      };
      
      # 硬件驱动配置
      drivers = {
        enable = true;                 # 🟢 启用硬件驱动模块
        
        # 音频驱动配置
        audio = {
          enable = true;               # 🟢 启用音频驱动 (PipeWire + ALSA)
          controls = true;             # 启用音频控制工具
        };
        
        # 触摸板驱动配置
        touchpad = {
          enable = true;               # 🟢 启用触摸板驱动 (libinput)
          gestures = false;            # 可选：启用手势支持
        };
        
        # 打印驱动配置
        printing = {
          enable = true;               # 🟢 启用打印功能 (CUPS)
          service = {
            discovery = true;          # 网络打印机自动发现
            sharing = false;           # 打印机网络共享
          };
          scanning = {
            enable = true;             # 启用扫描功能
            network = false;           # 网络扫描支持
          };
          tools = {
            gui = true;                # 图形管理工具
            maintenance = false;       # 打印机维护工具
          };
          # 根据需要启用特定品牌驱动
          drivers = {
            hp = false;                # HP 打印机驱动
            canon = false;             # Canon 打印机驱动
            epson = false;             # Epson 打印机驱动
            brother = false;           # Brother 打印机驱动
          };
        };
        
        bluetooth = {
          enable = true;               # 启用蓝牙支持
          gui = true;                  # 图形管理工具
        };
        
        # NVIDIA 显卡配置
        nvidia = {
          enable = true;               # 🟢 启用 NVIDIA 支持
          driver = {
            openSource = false;        # 使用专有驱动（性能更好）
            package = "stable";        # 驱动版本选择
          };
          power = {
            enable = true;             # 启用电源管理
            finegrained = false;       # 细粒度电源管理（可选）
            suspend = true;            # 挂起/唤醒支持
          };
          graphics = {
            vulkan = true;             # Vulkan API 支持
            cuda = false;              # CUDA 计算支持（需要时启用）
            nvenc = true;              # NVENC 视频编码
          };
          tools = {
            settings = true;           # NVIDIA 设置面板
            monitoring = true;         # 性能监控工具
            overclocking = false;      # 超频工具支持
          };
        };
      };
    };

  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #  };

  # 包管理配置
  myPkgs = {
    enable = true;                       # 启用包管理模块
    
    # 系统应用管理配置
    apps = {
      enable = true;                     # 启用系统应用模块
      shells.enable = true;              # Shell 工具
      terminals.enable = true;           # 终端工具
      develop.enable = true;         # 开发工具
      browsers.enable = true;            # 浏览器
      communication.enable = true;       # 通讯工具
      media.enable = true;               # 媒体工具
      office.enable = true;              # 办公工具
      gaming.enable = true;              # 游戏娱乐
      network.enable = true;             # 网络工具
    };
  };

  # system.copySystemConfiguration = true;


  # nix.settings.substituters = lib.mkForce [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  #      				      "https://mirrors.ustc.edu.cn/nix-channels/store"
  # ];

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

