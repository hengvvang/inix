{ config, lib, pkgs, ... }:

{
  # 蓝牙驱动模块的完整选项定义
  options.mySystem.services.drivers.bluetooth = {
    enable = lib.mkEnableOption "蓝牙驱动基础支持";
    
    # === 核心功能选项 ===
    core = {
      powerOnBoot = lib.mkEnableOption "开机自动启动蓝牙" // { default = true; };
      experimental = lib.mkEnableOption "实验性功能" // { default = true; };
      fastConnectable = lib.mkEnableOption "快速连接模式";
    };
    
    # === 音频支持选项 ===
    audio = {
      enable = lib.mkEnableOption "蓝牙音频支持" // { default = true; };
      a2dp = lib.mkEnableOption "A2DP 高质量音频";
      hsp = lib.mkEnableOption "HSP 耳机配置文件";
      codec = lib.mkOption {
        type = lib.types.enum [ "sbc" "aac" "aptx" "ldac" ];
        default = "sbc";
        description = "默认音频编解码器";
      };
    };
    
    # === 设备支持选项 ===
    devices = {
      input = lib.mkEnableOption "输入设备支持 (键盘、鼠标)";
      hid = lib.mkEnableOption "HID 设备支持";
      gamepad = lib.mkEnableOption "游戏手柄支持";
      serial = lib.mkEnableOption "串口设备支持";
    };
    
    # === 工具选项 ===
    tools = {
      gui = lib.mkEnableOption "图形界面管理工具";
      cli = lib.mkEnableOption "命令行工具";
      debugging = lib.mkEnableOption "调试工具";
    };
  };

  imports = [
    ./core.nix         # 核心蓝牙功能
    ./audio.nix        # 音频支持
    ./devices.nix      # 设备支持
    ./tools.nix        # 工具集
  ];
}
