{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      # <home-manager/nixos>
      ../../system
    ];

  # 音频配置
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # 触摸板支持
  services.libinput.enable = true;

  # 打印支持
  services.printing.enable = true;
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
    # 桌面环境配置
    desktop = {
      enable = true;                   # 启用桌面环境模块
      cosmic.enable = true;            # 使用 COSMIC 桌面环境
    };
    
    # 用户管理配置
    users = {
      enable = true;                   # 启用用户配置模块
    };
    
    # 系统包管理配置
    packages = {
      enable = true;                   # 启用系统包模块
    };

    # 本地化配置
    localization = {
      enable = true;                   # 启用本地化模块
      timeZone = {
        enable = true;                 # 启用时区配置
        shanghai.enable = true;        # 使用上海时区
      };
      inputMethod = {
        enable = true;                 # 启用输入法配置
        fcitx5.enable = true;          # 使用 fcitx5 输入法
      };
    };
    
    # 服务配置
    services = {
      enable = true;                   # 启用服务模块
      network = {
        enable = true;                 # 启用网络服务
        
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
            tunMode = true;           # TUN 模式（启用时生效）
            webPort = 9090;           # Web UI 端口
            mixedPort = 7890;         # HTTP/SOCKS5 混合端口
            subscriptionUrl = "https://your-clash-subscription-url";  # 🔴 替换为你的订阅链接
            autoStart = true;         # 系统启动时自动启动
            updateInterval = "daily"; # 订阅更新间隔
          };
          
          # V2Ray 代理服务
          v2ray = {
            enable = false;           # 🔴 禁用 - 需要时设为 true
            httpPort = 8080;          # HTTP 代理端口
            socksPort = 1080;         # SOCKS5 代理端口
            subscriptionUrl = "https://your-v2ray-subscription-url";  # 🔴 替换为你的订阅链接
            autoStart = false;        # 手动启动（避免与其他代理冲突）
            updateInterval = "daily"; # 订阅更新间隔
          };
          
          # Xray 代理服务
          xray = {
            enable = false;           # 🔴 禁用 - 需要时设为 true
            httpPort = 8081;          # HTTP 代理端口（避免冲突）
            socksPort = 1081;         # SOCKS5 代理端口（避免冲突）
            subscriptionUrl = "https://your-xray-subscription-url";   # 🔴 替换为你的订阅链接
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
          spotify = false;             # Spotify（需要时启用）
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
        bluetooth = {
          enable = true;               # 启用蓝牙支持
          core = {
            powerOnBoot = true;        # 开机自动启动蓝牙
            experimental = true;       # 启用实验性功能
            fastConnectable = false;   # 禁用快速连接（节能）
          };
          audio = {
            enable = true;             # 启用蓝牙音频
            a2dp = true;               # A2DP 高质量音频
            hsp = false;               # HSP 耳机配置文件
            codec = "sbc";             # 默认音频编解码器
          };
          devices = {
            input = true;              # 输入设备支持（键盘、鼠标）
            hid = true;                # HID 设备支持
            gamepad = false;           # 游戏手柄支持
            serial = false;            # 串口设备支持
          };
          tools = {
            gui = true;                # 图形界面管理工具
            cli = true;                # 命令行工具
            debugging = false;         # 调试工具
          };
        };
        
        # NVIDIA 显卡配置
        nvidia = {
          enable = true;               # 🟢 启用 NVIDIA 支持
          driver = {
            openSource = false;        # 使用专有驱动（性能更好）
            modesetting = true;        # 启用 modesetting
          };
          power = {
            enable = true;             # 启用电源管理
            finegrained = false;       # 细粒度电源管理（可选）
            suspend = true;            # 挂起/唤醒支持
          };
          graphics = {
            opengl = true;             # OpenGL 硬件加速
            vulkan = true;             # Vulkan API 支持
            cuda = false;              # CUDA 计算支持（需要时启用）
            nvenc = true;              # NVENC 视频编码
          };
          tools = {
            settings = true;           # NVIDIA 设置面板
            smi = true;                # nvidia-smi 工具
            persistenced = false;      # 持久化守护进程（可选）
          };
          performance = {
            coolbits = null;           # 超频支持（谨慎使用）
            powerLimit = null;         # 功耗限制
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

