{ config, lib, pkgs, ... }:

{
  # 蓝牙设备支持实现
  config = lib.mkMerge [
    # 输入设备支持
    (lib.mkIf (config.mySystem.services.drivers.bluetooth.enable && config.mySystem.services.drivers.bluetooth.devices.input) {
      hardware.bluetooth.settings.General.Enable = "Source,Sink,Media,Socket,Control";
    })
    
    # HID 设备支持
    (lib.mkIf (config.mySystem.services.drivers.bluetooth.enable && config.mySystem.services.drivers.bluetooth.devices.hid) {
      boot.kernelModules = [ "hid_generic" "uinput" ];
    })
    
    # 游戏手柄支持
    (lib.mkIf (config.mySystem.services.drivers.bluetooth.enable && config.mySystem.services.drivers.bluetooth.devices.gamepad) {
      environment.systemPackages = with pkgs; [
        joystick          # 游戏手柄工具
      ];
      
      boot.kernelModules = [ "uinput" "joydev" ];
    })
    
    # 串口设备支持
    (lib.mkIf (config.mySystem.services.drivers.bluetooth.enable && config.mySystem.services.drivers.bluetooth.devices.serial) {
      hardware.bluetooth.settings.General.Enable = "Source,Sink,Media,Socket,Serial";
    })
  ];
}
