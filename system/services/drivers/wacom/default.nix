{ config, lib, pkgs, ... }:

{
  # Wacom 数位板驱动模块的完整选项定义
  options.mySystem.services.drivers.wacom = {
    enable = lib.mkEnableOption "Wacom 数位板驱动基础支持";
    
    # === 核心驱动选项 ===
    driver = {
      xorg = lib.mkEnableOption "Xorg Wacom 驱动" // { default = true; };
      opentablet = lib.mkEnableOption "OpenTabletDriver 开源驱动";
      legacy = lib.mkEnableOption "传统 Wacom 驱动支持";
    };
    
    # === 设备功能选项 ===
    features = {
      pressure = lib.mkEnableOption "压感支持" // { default = true; };
      tilt = lib.mkEnableOption "倾斜角度支持";
      rotation = lib.mkEnableOption "旋转支持";
      touch = lib.mkEnableOption "触摸功能";
      buttons = lib.mkEnableOption "快捷按键支持";
    };
    
    # === 配置工具选项 ===
    tools = {
      gui = lib.mkEnableOption "图形配置工具" // { default = true; };
      calibration = lib.mkEnableOption "校准工具";
      mapping = lib.mkEnableOption "区域映射工具";
      hotkeys = lib.mkEnableOption "快捷键配置";
    };
    
    # === 应用集成选项 ===
    integration = {
      krita = lib.mkEnableOption "Krita 绘画软件集成";
      gimp = lib.mkEnableOption "GIMP 图像编辑集成";
      blender = lib.mkEnableOption "Blender 3D 建模集成";
      inkscape = lib.mkEnableOption "Inkscape 矢量图形集成";
    };
  };

  imports = [
    ./core.nix         # 核心驱动
    ./features.nix     # 设备功能
    ./tools.nix        # 配置工具
    ./integration.nix  # 应用集成
  ];
}
