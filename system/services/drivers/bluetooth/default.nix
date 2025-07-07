{ config, lib, pkgs, ... }:

{
  # 蓝牙驱动模块 - 简化版
  options.mySystem.services.drivers.bluetooth = {
    enable = lib.mkEnableOption "蓝牙驱动支持";
    
    # 核心功能
    powerOnBoot = lib.mkEnableOption "开机自动启动蓝牙" // { default = true; };
    experimental = lib.mkEnableOption "实验性功能" // { default = true; };
    
    # 音频支持
    audio = {
      enable = lib.mkEnableOption "蓝牙音频支持" // { default = true; };
      a2dp = lib.mkEnableOption "A2DP 高质量音频" // { default = true; };
    };
    
    # 设备和工具
    gui = lib.mkEnableOption "图形管理工具" // { default = true; };
    inputDevices = lib.mkEnableOption "输入设备支持（键盘、鼠标）" // { default = true; };
  };

  imports = [
    ./core.nix       # 核心蓝牙功能（包含设备和工具支持）
    ./audio.nix      # 音频支持
  ];
}
