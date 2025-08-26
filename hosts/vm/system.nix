{ config, lib, pkgs, ... }:

{
  mySystem = {
    desktop = {
      enable = true;
      preset = "niri";
    };

    profiles = {
      enable = true;
      fonts = {
        enable = false;
        preset = "zen";
      };
      # 启用系统级统一主题配置
      stylix = {
        enable = false;
        colorScheme = {
          mode = "preset";
          preset.name = "catppuccin-mocha";  # 统一使用深色主题
        };
        polarity = "dark";  # 强制深色模式
        # 系统级目标
        targets = {
          gtk.enable = true;
          console.enable = true;
        };
        # Home Manager 集成
        homeManagerIntegration = {
          autoImport = true;   # 自动为所有用户导入
          followSystem = true; # 用户配置跟随系统配置
        };
      };
    };

    locale = {
      enable = true;
      timeZone = {
        enable = true;
        preset = "shanghai";
      };
      inputMethod = {
        enable = true;
        fcitx5.enable = true;
      };
    };

    services = {
      enable = true;
      containers = {
        enable = false;
        appimage = {
          enable = false;
        };
        docker = {
          enable = false;
          rootless = false;            # 使用标准 Docker 模式
          nvidia = false;
          registry = {
            enable = false;            # 暂不启用本地 Registry
            port = 5000;              # Registry 端口
          };
        };
        flatpak = {
          enable = false;
          flathub.enable = true;              # 启用 Flathub 仓库
          xdgPortal.enable = true;            # 启用 XDG 门户支持
        };
      };

      network = {
        enable = true;
        manager = {
          enable = true;
          hostname = "vm";
          preset = "networkmanager";
          tools = {
            enable = true;
            gui = true;
          };
        };
        ssh = {
          enable = true;
          server = {
            enable = true;             # 启用 SSH 服务端
            port = 22;                 # SSH 端口
            passwordAuth = false;      # 禁用密码认证，仅使用密钥认证
          };
          client = {
            enable = true;             # 启用 SSH 客户端工具
          };
        };
        # 虚拟网卡支持（TUN/TAP）
        virtualInterface = {
          enable = false;
          tun = true;                  # 启用 TUN 支持
          tap = false;                 # 禁用 TAP 支持
          forwarding = {
            ipv4 = true;               # 启用 IPv4 转发
            ipv6 = false;              # 禁用 IPv6 转发
          };
          tools = {
            basic = true;              # 启用基础网络工具
            bridge = false;            # 禁用网桥工具
          };
        };
        proxy = {
          enable = false;
          mihomo = {
            enable = false;
            webui = "metacubexd";  # 使用 metacubexd Web UI
            tunMode = true;
            configFile.enable = true;
            extraOpts.enable = false;
          };
        };
      };

      media = {
        enable = false;
        video = {
          enable = true;
          mpv = true;
          vlc = false;
        };
        audio = {
          enable = true;
          spotify = false;
        };
        codecs = {
          enable = true;               # 启用编解码器
          ffmpeg = true;               # FFmpeg
          gstreamer = false;           # GStreamer
        };
        streaming = {
          enable = true;
          download = true;
        };
        mpd = {
          enable = false;              # � 禁用系统级 MPD - 使用用户级配置
        #   musicDirectory = "/srv/Music";  # 用户音乐目录，更合理的位置
        #   port = 6600;                 # MPD 服务端口
        #   httpPort = 8000;             # HTTP 音频流端口
        #   enableFileOutput = false;    # 暂时禁用 FIFO 输出避免崩溃
        };
      };

      # 硬件驱动配置
      drivers = {
        enable = true;
        audio = {
          enable = true;
          toolkits = true;
        };
        touchpad = {
          enable = false;
          gestures = false;            # 可选：启用手势支持
        };
        # 打印驱动配置
        printing = {
          enable = false;
          service = {
            discovery = true;          # 网络打印机自动发现
            sharing = false;           # 打印机网络共享
          };
          scanning = {
            enable = false;             # 启用扫描功能
            network = false;           # 网络扫描支持
          };
          tools = {
            gui = true;
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
          enable = false;               # 🟢 启用 NVIDIA 支持
          driver = {
            openSource = false;        # 使用专有驱动（性能更好）
            package = "stable";        # 驱动版本选择
          };
          power = {
            enable = true;             # 启用电源管理
            finegrained = false;       # 细粒度电源管理（可选）
            suspend = true;            # 挂起/唔醒支持
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

        # 调试探针配置
        debug = {
          enable = false;               # 🟢 启用调试探针支持
          stlink = true;               # ST-Link 调试器
          jlink = true;                # J-Link 调试器
          daplink = true;              # DAPLink 调试器
          blackmagic = true;           # Black Magic Probe
        };
      };
    };
  };
}
