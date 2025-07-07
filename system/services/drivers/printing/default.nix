{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.printing;
in
{
  # 打印和扫描驱动配置选项
  options.mySystem.services.drivers.printing = {
    enable = lib.mkEnableOption "打印和扫描功能支持";
    
    # 核心服务选项
    service = {
      discovery = lib.mkEnableOption "网络打印机自动发现" // { default = true; };
      sharing = lib.mkEnableOption "打印机网络共享" // { default = false; };
    };
    
    # 打印机品牌驱动
    drivers = {
      hp = lib.mkEnableOption "HP 打印机驱动" // { default = false; };
      canon = lib.mkEnableOption "Canon 打印机驱动" // { default = false; };
      epson = lib.mkEnableOption "Epson 打印机驱动" // { default = false; };
      brother = lib.mkEnableOption "Brother 打印机驱动" // { default = false; };
    };
    
    # 扫描功能
    scanning = {
      enable = lib.mkEnableOption "扫描功能支持" // { default = true; };
      network = lib.mkEnableOption "网络扫描支持" // { default = false; };
    };
    
    # 管理工具
    tools = {
      gui = lib.mkEnableOption "图形管理工具" // { default = true; };
      maintenance = lib.mkEnableOption "打印机维护工具" // { default = false; };
    };
  };

  imports = [
    ./scanning.nix    # 扫描功能模块
  ];

  # 打印驱动基础实现
  config = lib.mkIf cfg.enable {
    # === CUPS 打印服务 ===
    services.printing = {
      enable = true;
      startWhenNeeded = true;
      webInterface = true;
      allowFrom = [ "localhost" "192.168.0.0/16" "10.0.0.0/8" ];
      defaultShared = cfg.service.sharing;
      
      # 合并所有打印机驱动
      drivers = with pkgs; [
        # 通用驱动 (默认包含)
        cups-filters
        ghostscript
        gutenprint
      ] ++ lib.optionals cfg.drivers.hp [
        # HP 打印机驱动
        hplip
        hplipWithPlugin
      ] ++ lib.optionals cfg.drivers.canon [
        # Canon 打印机驱动
        canon-cups-ufr2
        cnijfilter2
      ] ++ lib.optionals cfg.drivers.epson [
        # Epson 打印机驱动
        epson-escpr
        epson-escpr2
      ] ++ lib.optionals cfg.drivers.brother [
        # Brother 打印机驱动
        brlaser
        brother-cups-wrapper
      ];
    };
    
    # === 网络打印机发现 ===
    services.avahi = lib.mkIf cfg.service.discovery {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
    
    # === 系统包和工具 ===
    environment.systemPackages = with pkgs; [
      # 基础打印工具
      cups
      cups-filters
      
      # 图形管理工具
    ] ++ lib.optionals cfg.tools.gui [
      system-config-printer   # 打印机配置 GUI
      gtk3.dev               # 打印对话框支持
    ] ++ lib.optionals cfg.tools.maintenance [
      # 打印机维护工具
      ink                    # 墨水量检测
    ] ++ lib.optionals cfg.drivers.hp [
      # HP 专用工具
      hplip                  # HP 打印机工具套件
    ] ++ lib.optionals cfg.drivers.canon [
      # Canon 专用工具
      scangearmp2           # Canon 扫描工具
    ];
    
    # === 用户组和权限 ===
    users.groups = {
      lp = {};              # 打印组
      lpadmin = {};         # 打印管理组
    };
    
    # 打印设备权限
    services.udev.extraRules = ''
      # USB 打印机权限
      SUBSYSTEM=="usb", ATTR{bDeviceClass}=="07", GROUP="lp", MODE="0664"
      
      # 并口打印机权限
      KERNEL=="lp[0-9]*", GROUP="lp", MODE="0664"
      
      # 打印机设备节点权限
      SUBSYSTEM=="usb", ATTR{bInterfaceClass}=="07", GROUP="lp", MODE="0664"
    '';
    
    # === 防火墙配置 ===
    networking.firewall = lib.mkIf cfg.service.sharing {
      allowedTCPPorts = [
        631    # CUPS 服务
        515    # LPD 协议
      ];
      allowedUDPPorts = [
        631    # CUPS 广播
        5353   # mDNS/Bonjour
      ];
    };
  };
}
