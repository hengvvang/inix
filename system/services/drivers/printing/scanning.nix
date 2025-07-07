{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.printing;
in
{
  # 扫描功能实现
  config = lib.mkIf (cfg.enable && cfg.scanning.enable) {
    # === SANE 扫描服务 ===
    hardware.sane = {
      enable = true;
      extraBackends = with pkgs; [
        sane-airscan      # 网络扫描器支持
        sane-backends     # 基础扫描后端
      ] ++ lib.optionals cfg.drivers.hp [
        hplipWithPlugin   # HP 扫描器
      ] ++ lib.optionals cfg.drivers.canon [
        scangearmp2       # Canon 扫描器
      ] ++ lib.optionals cfg.drivers.epson [
        utsushi          # Epson 扫描器
      ];
      
      # 网络扫描配置
      netConf = lib.mkIf cfg.scanning.network ''
        # 允许本地网络扫描器
        192.168.0.0/16
        10.0.0.0/8
        172.16.0.0/12
      '';
    };
    
    # === 扫描工具包 ===
    environment.systemPackages = with pkgs; [
      # 基础扫描工具
      sane-backends
      sane-frontends
    ] ++ lib.optionals cfg.tools.gui [
      # 图形扫描工具
      simple-scan       # GNOME 简单扫描
      xsane            # 功能丰富的扫描工具
      gscan2pdf        # 扫描到 PDF
    ] ++ lib.optionals cfg.scanning.network [
      # 网络扫描支持
      sane-airscan     # AirScan/eSCL 协议
    ] ++ lib.optionals cfg.drivers.hp [
      # HP 扫描工具
      hplip            # HP 扫描器工具
    ];
    
    # === 用户组和权限 ===
    users.groups.scanner = {};
    
    # 扫描设备权限
    services.udev.packages = with pkgs; [
      sane-backends
    ];
    
    services.udev.extraRules = ''
      # USB 扫描器权限
      SUBSYSTEM=="usb", ENV{libsane_matched}=="yes", GROUP="scanner", MODE="0664"
      
      # 网络扫描器发现
      SUBSYSTEM=="net", ACTION=="add", RUN+="${pkgs.sane-airscan}/bin/airscan-discover"
      
      # 扫描器设备节点权限
      KERNEL=="sg[0-9]*", GROUP="scanner", MODE="0664"
    '';
    
    # === 网络扫描防火墙 ===
    networking.firewall = lib.mkIf cfg.scanning.network {
      allowedTCPPorts = [
        8080   # eSCL 扫描协议
        9100   # RAW 打印/扫描
      ];
      allowedUDPPorts = [
        5353   # mDNS 发现
      ];
    };
  };
}
