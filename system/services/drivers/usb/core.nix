{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.usb;
in
{
  config = lib.mkIf cfg.enable {
    # USB 存储支持
    services.udisks2 = lib.mkIf cfg.core.storage {
      enable = true;
      mountOnMedia = true;
    };
    
    # 自动挂载
    services.devmon = lib.mkIf cfg.core.automount {
      enable = true;
    };
    
    # GVFS 支持（GNOME 虚拟文件系统）
    services.gvfs = lib.mkIf cfg.core.automount {
      enable = true;
    };
    
    # 热插拔支持和权限配置
    services.udev = lib.mkIf cfg.core.hotplug {
      enable = true;
      extraRules = ''
        # USB 设备权限
        SUBSYSTEM=="usb", GROUP="plugdev", MODE="0664"
        SUBSYSTEM=="block", SUBSYSTEMS=="usb", GROUP="plugdev", MODE="0664"
      '';
    };
    
    # 基础 USB 工具
    environment.systemPackages = with pkgs; [
      usbutils          # USB 工具集
      usb-modeswitch    # USB 模式切换
    ];
    
    # USB 权限配置
    users.groups.plugdev = {};
  };
}
