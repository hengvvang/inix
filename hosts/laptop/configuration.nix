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
    desktop.cosmic.enable = true;      # 桌面环境 - laptop需要图形界面
    hardware.enable = true;     # 硬件配置 - 基础需求
    users.enable = true;        # 用户配置 - 必需
    packages.enable = true;     # 系统包 - 完整软件环境
    
    # 本地化配置 - 支持细粒度控制
    localization = {
      enable = true;
      # 时区选择 (只能选择一个)
      timeZone.shanghai = true;        # 中国上海时区
      # timeZone.newYork = true;       # 美国纽约时区
      # timeZone.losAngeles = true;    # 美国洛杉矶时区
      
      # 输入法选择 (只能选择一个)
      inputMethod.fcitx5 = true;       # 推荐：Fcitx5 (最新)
      # inputMethod.ibus = true;       # 备选：IBus
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

