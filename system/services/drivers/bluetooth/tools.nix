{ config, lib, pkgs, ... }:

{
  # 蓝牙工具实现
  config = lib.mkMerge [
    # 图形界面工具
    (lib.mkIf (config.mySystem.services.drivers.bluetooth.enable && config.mySystem.services.drivers.bluetooth.tools.gui) {
      services.blueman.enable = true;
      
      environment.systemPackages = with pkgs; [
        blueman           # 蓝牙管理器GUI
        blueberry         # 简单蓝牙管理器
      ];
    })
    
    # 命令行工具
    (lib.mkIf (config.mySystem.services.drivers.bluetooth.enable && config.mySystem.services.drivers.bluetooth.tools.cli) {
      environment.systemPackages = with pkgs; [
        bluetuith         # TUI 蓝牙管理器
        # bluetoothctl 已包含在 bluez 中（core.nix 已安装）
      ];
    })
    
    # 调试工具
    (lib.mkIf (config.mySystem.services.drivers.bluetooth.enable && config.mySystem.services.drivers.bluetooth.tools.debugging) {
      environment.systemPackages = with pkgs; [
        bluez-tools       # 蓝牙调试工具
        wireshark         # 协议分析
      ];
    })
  ];
}
