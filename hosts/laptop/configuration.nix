{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      # <home-manager/nixos>
      ../../system
    ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;               # 使用闭源驱动
    nvidiaSettings = true;      # 安装 nvidia-settings 图形工具
  };

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
    desktop.cosmic.enable = true;       # 桌面环境 - laptop需要图形界面
    users.enable = true;                # 用户配置 - 必需
    packages.enable = true;             # 系统包 - 完整软件环境

    localization = {
      timeZone.shanghai.enable = true;
      inputMethod.fcitx5.enable = true;
    };
    
    # 代理服务配置 - 预设所有选项，默认禁用，按需启用
    services.network.proxy = {
      # Clash 代理服务
      clash = {
        enable = false;                # 🔴 禁用 - 需要时设为 true
        tunMode = true;               # TUN 模式（启用时生效）
        webPort = 9090;               # Web UI 端口
        mixedPort = 7890;             # HTTP/SOCKS5 混合端口
        subscriptionUrl = "https://your-clash-subscription-url";  # 🔴 替换为你的订阅链接
        autoStart = true;             # 系统启动时自动启动
        updateInterval = "daily";     # 订阅更新间隔
      };
      
      # V2Ray 代理服务
      v2ray = {
        enable = false;               # 🔴 禁用 - 需要时设为 true
        httpPort = 8080;              # HTTP 代理端口
        socksPort = 1080;             # SOCKS5 代理端口
        subscriptionUrl = "https://your-v2ray-subscription-url";  # 🔴 替换为你的订阅链接
        autoStart = false;            # 手动启动（避免与其他代理冲突）
        updateInterval = "daily";     # 订阅更新间隔
      };
      
      # Xray 代理服务
      xray = {
        enable = false;               # 🔴 禁用 - 需要时设为 true
        httpPort = 8081;              # HTTP 代理端口（避免冲突）
        socksPort = 1081;             # SOCKS5 代理端口（避免冲突）
        subscriptionUrl = "https://your-xray-subscription-url";   # 🔴 替换为你的订阅链接
        autoStart = false;            # 手动启动（避免与其他代理冲突）
        updateInterval = "daily";     # 订阅更新间隔
      };
      
      # Shadowsocks 代理服务
      shadowsocks = {
        enable = false;               # 🔴 禁用 - 需要时设为 true
        localPort = 1082;             # 本地代理端口（避免冲突）
        subscriptionUrl = "https://your-shadowsocks-subscription-url";  # 🔴 替换为你的订阅链接
        autoStart = false;            # 手动启动（避免与其他代理冲突）
        updateInterval = "daily";     # 订阅更新间隔
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

