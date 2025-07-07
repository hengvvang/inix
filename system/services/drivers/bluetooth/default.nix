{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.bluetooth;
in
{
  # 蓝牙驱动模块 - 极简版
  options.mySystem.services.drivers.bluetooth = {
    enable = lib.mkEnableOption "蓝牙驱动支持";
    gui = lib.mkEnableOption "图形管理工具" // { default = true; };
  };

  config = lib.mkIf cfg.enable {
    # 启用蓝牙硬件支持
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket,Control";
          Experimental = true;
          DiscoverableTimeout = 0;
          PairableTimeout = 0;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };

    # 蓝牙服务
    systemd.services.bluetooth.enable = true;

    # 蓝牙工具包
    environment.systemPackages = with pkgs; [
      bluez             # 蓝牙协议栈
      bluez-tools       # 蓝牙工具集
      bluetuith         # TUI 蓝牙管理器
      pulseaudio-ctl    # 音频控制
      pavucontrol       # 音频设置GUI
    ] ++ lib.optionals cfg.gui [
      blueman           # 蓝牙管理器GUI
      blueberry         # 简单蓝牙管理器
    ];

    # 输入设备内核模块
    boot.kernelModules = [ "hid_generic" "uinput" ];

    # 用户组和权限
    users.groups.bluetooth = {};
    services.udev.extraRules = ''
      # 蓝牙设备权限
      KERNEL=="rfkill", SUBSYSTEM=="rfkill", GROUP="bluetooth", MODE="0664"
      SUBSYSTEM=="bluetooth", GROUP="bluetooth", MODE="0664"
    '';
  };
}
