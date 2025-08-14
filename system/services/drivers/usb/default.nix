{ config, lib, pkgs, ... }:

{
  imports = [
    ./usb.nix
    ./security.nix
  ];
  # USB 设备驱动模块
  options.mySystem.services.drivers.usb = {
    enable = lib.mkEnableOption "USB 设备支持";

    # 基础功能
    automount = lib.mkEnableOption "自动挂载 USB 设备" // { default = true; };
    filesystems = lib.mkEnableOption "常用文件系统支持" // { default = true; };

    # 设备类型支持
    devices = {
      audio = lib.mkEnableOption "USB 音频设备" // { default = false; };
      video = lib.mkEnableOption "USB 视频设备" // { default = false; };
    };

    # 安全和管理
    security = {
      enable = lib.mkEnableOption "USB 安全管理";
      usbguard = lib.mkEnableOption "USBGuard 设备授权" // { default = false; };
    };

    # 管理工具
    tools = lib.mkEnableOption "USB 管理工具" // { default = true; };
  };
}
