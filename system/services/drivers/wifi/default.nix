{ config, lib, pkgs, ... }:

{
  # WiFi 驱动模块的完整选项定义
  options.mySystem.services.drivers.wifi = {
    enable = lib.mkEnableOption "WiFi 驱动基础支持";
    
    # === 网络管理选项 ===
    manager = {
      type = lib.mkOption {
        type = lib.types.enum [ "networkmanager" "wpa_supplicant" "iwd" ];
        default = "networkmanager";
        description = "WiFi 网络管理器";
      };
      powersave = lib.mkEnableOption "WiFi 节能模式";
    };
    
    # === 固件选项 ===
    firmware = {
      redistributable = lib.mkEnableOption "可再分发固件" // { default = true; };
      nonfree = lib.mkEnableOption "非自由固件";
    };
    
    # === 工具选项 ===
    tools = {
      gui = lib.mkEnableOption "图形界面工具";
      monitoring = lib.mkEnableOption "WiFi 监控工具";
      security = lib.mkEnableOption "WiFi 安全工具";
      advanced = lib.mkEnableOption "高级 WiFi 工具";
    };
    
    # === 热点选项 ===
    hotspot = {
      enable = lib.mkEnableOption "WiFi 热点功能";
      interface = lib.mkOption {
        type = lib.types.str;
        default = "wlan0";
        description = "热点接口名称";
      };
    };
  };

  imports = [
    ./core.nix         # 核心 WiFi 功能
    ./manager.nix      # 网络管理器
    ./tools.nix        # WiFi 工具
    ./hotspot.nix      # 热点功能
  ];
}
