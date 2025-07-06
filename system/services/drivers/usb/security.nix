{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.usb;
in
{
  config = lib.mkIf cfg.enable {
    # 设备白名单
    services.usbguard = lib.mkIf cfg.security.whitelist {
      enable = true;
      rules = ''
        # 允许已连接的设备
        allow with-interface equals { 08:*:* }  # 大容量存储
        allow with-interface equals { 03:*:* }  # HID 设备
        allow with-interface equals { 09:*:* }  # Hub 设备
        
        # 阻止未知设备
        reject
      '';
    };
    
    # 加密存储支持
    boot.initrd.luks.devices = lib.mkIf cfg.security.encryption {};
    
    environment.systemPackages = lib.optionals cfg.security.encryption (with pkgs; [
      cryptsetup        # LUKS 加密
      veracrypt         # VeraCrypt 加密
    ]);
    
    # 只读模式选项
    services.udisks2.settings = lib.mkIf cfg.security.readonly {
      "mount-options.conf" = {
        defaults = "ro,nosuid,nodev,noexec";
      };
    };
    
    # 安全工具
    environment.systemPackages = lib.optionals cfg.security.whitelist (with pkgs; [
      usbguard          # USB 设备控制
    ]);
  };
}
  };
}
