{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.debug;
in
{
  config = lib.mkIf cfg.enable {
    # 基础包支持
    environment.systemPackages = with pkgs; [
      openocd           # 通用调试器支持
      gdb               # GDB 调试器
      usbutils          # USB 工具
    ];

    # 用户组配置 - 确保必要的组存在
    users.groups = {
      plugdev = {};     # USB 设备访问组（通常需要手动创建）
      # dialout 组通常由系统自动创建，但确保存在
      dialout = {};
    };

    # udev 规则 - 调试探针设备权限
    services.udev.extraRules = lib.concatStringsSep "\n" (
      lib.optionals cfg.stlink [
        # ST-Link 调试器
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="0666", GROUP="plugdev"''
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="0666", GROUP="plugdev"''
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374e", MODE="0666", GROUP="plugdev"''
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374f", MODE="0666", GROUP="plugdev"''
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3752", MODE="0666", GROUP="plugdev"''
      ] ++ lib.optionals cfg.jlink [
        # J-Link 调试器
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0101", MODE="0666", GROUP="plugdev"''
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0102", MODE="0666", GROUP="plugdev"''
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0103", MODE="0666", GROUP="plugdev"''
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0105", MODE="0666", GROUP="plugdev"''
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0107", MODE="0666", GROUP="plugdev"''
      ] ++ lib.optionals cfg.daplink [
        # DAPLink/CMSIS-DAP 调试器
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="0d28", ATTRS{idProduct}=="0204", MODE="0666", GROUP="plugdev"''
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="c251", ATTRS{idProduct}=="f001", MODE="0666", GROUP="plugdev"''
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="1fc9", ATTRS{idProduct}=="0132", MODE="0666", GROUP="plugdev"''
      ] ++ lib.optionals cfg.blackmagic [
        # Black Magic Probe
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="6018", MODE="0666", GROUP="plugdev"''
        ''SUBSYSTEM=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="6017", MODE="0666", GROUP="plugdev"''
      ] ++ [
        # 通用串口设备
        ''KERNEL=="ttyUSB[0-9]*", MODE="0666", GROUP="dialout"''
        ''KERNEL=="ttyACM[0-9]*", MODE="0666", GROUP="dialout"''
      ]
    );
  };
}
