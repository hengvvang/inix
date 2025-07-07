{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.usb;
in
{
  # USB 安全功能实现
  config = lib.mkIf (cfg.enable && cfg.security.enable) {
    # USBGuard 设备授权
    services.usbguard = lib.mkIf cfg.security.usbguard {
      enable = true;
      rules = ''
        # 允许常用设备类型
        allow with-interface equals { 08:*:* }  # 大容量存储
        allow with-interface equals { 03:*:* }  # HID 设备 (键盘、鼠标)
        allow with-interface equals { 09:*:* }  # USB Hub
        allow with-interface equals { 01:*:* }  # 音频设备
        allow with-interface equals { 0e:*:* }  # 视频设备
        
        # 阻止其他未知设备
        block
      '';
      
      # 用户策略
      IPCAllowedUsers = [ "root" "usb" ];
      IPCAllowedGroups = [ "wheel" ];
    };
    
    # 安全相关工具
    environment.systemPackages = with pkgs; lib.optionals cfg.security.enable [
      usbguard           # USB 设备管理
      lsof               # 查看设备使用情况
      fuser              # 查找使用文件的进程
    ];
    
    # USB 安全组
    users.groups.usb = {};
    
    # 安全 udev 规则
    services.udev.extraRules = ''
      # 限制敏感 USB 设备权限
      SUBSYSTEM=="usb", ATTR{authorized}=="0", GROUP="usb", MODE="0660"
      # 自动授权已知安全设备
      SUBSYSTEM=="usb", ATTR{bDeviceClass}=="08", ATTR{authorized}="1"
      SUBSYSTEM=="usb", ATTR{bDeviceClass}=="03", ATTR{authorized}="1"
    '';
  };
}
