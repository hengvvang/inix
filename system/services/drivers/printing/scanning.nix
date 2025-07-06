{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.printing;
in
{
  config = lib.mkIf (cfg.enable && cfg.scanning.enable) {
    # SANE 扫描配置合并
    hardware.sane = lib.mkMerge [
      # 基础 SANE 配置
      (lib.mkIf cfg.scanning.sane {
        enable = true;
        extraBackends = with pkgs; [
          sane-airscan      # 网络扫描器
          hplipWithPlugin   # HP 扫描器
        ];
      })
      # 网络扫描支持
      (lib.mkIf cfg.scanning.network {
        netConf = ''
          # 网络扫描器配置
          192.168.0.0/16
        '';
      })
    ];
    
    # 扫描工具
    environment.systemPackages = with pkgs; [
      sane-backends      # SANE 后端
      sane-frontends     # SANE 前端
    ] ++ lib.optionals cfg.scanning.sane [
      simple-scan        # 简单扫描工具
      xsane             # 高级扫描工具
    ] ++ lib.optionals cfg.scanning.network [
      sane-airscan      # AirScan/eSCL 支持
    ];
    
    # 用户权限
    users.groups.scanner = {};
    
    # udev 规则
    services.udev.packages = with pkgs; [
      sane-backends
    ];
    
    # 扫描器权限配置
    services.udev.extraRules = ''
      # 扫描器设备权限
      SUBSYSTEM=="usb", ENV{libsane_matched}=="yes", GROUP="scanner", MODE="0664"
    '';
  };
}
