{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.touchpad;
in
{
  # 触摸板驱动模块 - 极简版
  options.mySystem.services.drivers.touchpad = {
    enable = lib.mkEnableOption "触摸板驱动支持";
    gestures = lib.mkEnableOption "手势支持" // { default = false; };
  };

  config = lib.mkIf cfg.enable {
    # 启用 libinput 触摸板支持
    services.libinput = {
      enable = true;
      touchpad = {
        # 基础触摸板配置
        tapping = true;              # 轻触点击
        clickMethod = "clickfinger"; # 点击方式
        naturalScrolling = true;     # 自然滚动
        horizontalScrolling = true;  # 水平滚动
        disableWhileTyping = true;   # 打字时禁用
        accelSpeed = "0.3";         # 加速度
      };
    };

    # 手势支持工具
    environment.systemPackages = with pkgs; lib.optionals cfg.gestures [
      libinput-gestures  # 手势识别
      touchegg           # 触摸手势工具
      fusuma             # 多点触控手势
    ];

    # 触摸板设备权限
    services.udev.extraRules = ''
      # 触摸板设备权限
      KERNEL=="event*", SUBSYSTEM=="input", ATTRS{name}=="*TouchPad*", GROUP="input", MODE="0664"
      KERNEL=="event*", SUBSYSTEM=="input", ATTRS{name}=="*Touchpad*", GROUP="input", MODE="0664"
    '';

    # 用户组权限
    users.groups.input = {};
  };
}
