{ config, lib, pkgs, ... }:

{
  # 触摸板驱动模块的完整选项定义
  options.mySystem.services.drivers.touchpad = {
    enable = lib.mkEnableOption "触摸板驱动基础支持";
    
    # === 基础功能选项 ===
    basic = {
      tapping = lib.mkEnableOption "轻触点击" // { default = true; };
      clickMethod = lib.mkOption {
        type = lib.types.enum [ "buttonareas" "clickfinger" ];
        default = "clickfinger";
        description = "点击方式";
      };
    };
    
    # === 滚动选项 ===
    scrolling = {
      naturalScrolling = lib.mkEnableOption "自然滚动" // { default = true; };
      twoFingerScrolling = lib.mkEnableOption "双指滚动" // { default = true; };
      edgeScrolling = lib.mkEnableOption "边缘滚动";
      horizontalScrolling = lib.mkEnableOption "水平滚动" // { default = true; };
    };
    
    # === 手势选项 ===
    gestures = {
      multitouch = lib.mkEnableOption "多点触控手势";
      swipeGestures = lib.mkEnableOption "滑动手势";
      pinchZoom = lib.mkEnableOption "缩放手势";
    };
    
    # === 敏感度选项 ===
    sensitivity = {
      speed = lib.mkOption {
        type = lib.types.float;
        default = 0.0;
        description = "指针速度 (-1.0 到 1.0)";
      };
      acceleration = lib.mkOption {
        type = lib.types.enum [ "none" "adaptive" "flat" ];
        default = "adaptive";
        description = "加速配置";
      };
    };
  };

  imports = [
    ./core.nix         # 核心触摸板功能（包含所有实现）
  ];
}
