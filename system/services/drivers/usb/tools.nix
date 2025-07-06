{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.usb;
in
{
  config = lib.mkIf cfg.enable {
    # USB 管理工具
    environment.systemPackages = lib.optionals cfg.tools.management (with pkgs; [
      usbutils          # lsusb 等工具
      usb-modeswitch    # USB 模式切换
      udisks            # 磁盘管理
    ]) ++ lib.optionals cfg.tools.debugging (with pkgs; [
      usbview           # USB 设备树查看器
    ]) ++ lib.optionals cfg.tools.security (with pkgs; [
      usbguard          # USB 设备控制
    ]) ++ lib.optionals cfg.tools.benchmark (with pkgs; [
      hdparm            # 硬盘性能测试
    ]);
  };
}
