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
    
    # 安全策略脚本
    environment.etc."usb-security.sh" = lib.mkIf (cfg.security.whitelist || cfg.security.encryption) {
      text = ''
        #!/bin/sh
        # USB 安全策略脚本
        echo "=== USB 安全状态 ==="
        
        ${lib.optionalString cfg.security.whitelist ''
        echo "USBGuard 状态:"
        systemctl status usbguard 2>/dev/null || echo "USBGuard 未运行"
        
        echo -e "\nUSBGuard 规则:"
        usbguard list-rules 2>/dev/null || echo "无法获取规则"
        ''}
        
        ${lib.optionalString cfg.security.encryption ''
        echo -e "\n加密设备状态:"
        cryptsetup status 2>/dev/null || echo "无活动加密设备"
        ''}
        
        echo -e "\n当前 USB 设备:"
        lsusb | wc -l
        echo "个 USB 设备已连接"
      '';
      mode = "0755";
    };
    
    # 安全审计脚本
    environment.etc."usb-audit.sh" = lib.mkIf cfg.security.whitelist {
      text = ''
        #!/bin/sh
        # USB 安全审计脚本
        echo "=== USB 安全审计 ==="
        
        echo "最近连接的 USB 设备:"
        dmesg | grep -i "usb.*connected" | tail -10
        
        echo -e "\n可疑 USB 活动:"
        dmesg | grep -i "usb.*reject\|usb.*block" | tail -5
        
        echo -e "\nUSB 设备变更历史:"
        journalctl -u usbguard --since "1 hour ago" --no-pager 2>/dev/null || echo "无 USBGuard 日志"
      '';
      mode = "0755";
    };
  };
}
