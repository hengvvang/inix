{ config, lib, pkgs, ... }:

{
  imports = [
    ./wifi.nix      # WiFi 核心驱动和固件
    ./manager.nix   # 网络管理器配置
    ./hotspot.nix   # WiFi 热点功能
    ./tools.nix     # WiFi 工具集
  ];
  # WiFi 无线网络驱动模块
  options.mySystem.services.drivers.wifi = {
    enable = lib.mkEnableOption "WiFi 无线网络驱动支持";
    # 固件配置
    firmware = {
      redistributable = lib.mkEnableOption "可重新分发固件" // { default = true; };
      nonfree = lib.mkEnableOption "非自由固件" // { default = true; };
    };
    # 网络管理器选择
    manager = {
      type = lib.mkOption {
        type = lib.types.enum [ "networkmanager" "wpa_supplicant" "iwd" ];
        default = "networkmanager";
        description = "WiFi 网络管理器类型";
      };
      powersave = lib.mkEnableOption "WiFi 节能模式" // { default = true; };
    };
    # WiFi 热点功能
    hotspot = {
      enable = lib.mkEnableOption "WiFi 热点功能";
      interface = lib.mkOption {
        type = lib.types.str;
        default = "wlan0";
        description = "热点使用的网络接口";
      };
    };
    # 工具和调试
    tools = {
      gui = lib.mkEnableOption "图形管理工具" // { default = true; };
      monitoring = lib.mkEnableOption "网络监控工具" // { default = false; };
      debugging = lib.mkEnableOption "调试和分析工具" // { default = false; };
    };
  };
}
