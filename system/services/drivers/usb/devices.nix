{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.usb;
in
{
  config = lib.mkIf cfg.enable {
    # USB 设备内核模块合并
    boot.kernelModules = lib.flatten [
      # 大容量存储设备
      (lib.optionals cfg.devices.massStorage [
        "usb-storage"
        "uas"
      ])
      # HID 人机接口设备
      (lib.optionals cfg.devices.hid [
        "usbhid"
        "hid-generic"
      ])
      # USB 音频设备
      (lib.optionals cfg.devices.audio [
        "snd-usb-audio"
      ])
      # USB 视频设备
      (lib.optionals cfg.devices.video [
        "uvcvideo"
        "v4l2loopback"
      ])
      # USB 调制解调器
      (lib.optionals cfg.devices.modem [
        "cdc_acm"
        "cdc_wdm"
        "cdc_ncm"
      ])
    ];
    
    # USB 打印机
    services.printing = lib.mkIf cfg.devices.printer {
      enable = true;
      drivers = with pkgs; [ cups-filters ];
    };
    
    # 设备特定工具
    environment.systemPackages = lib.mkMerge [
      (lib.mkIf cfg.devices.audio (with pkgs; [
        alsa-utils      # ALSA 音频工具
        pulseaudio      # PulseAudio 工具
      ]))
      
      (lib.mkIf cfg.devices.video (with pkgs; [
        v4l-utils       # Video4Linux 工具
        ffmpeg          # 视频处理
      ]))
      
      (lib.mkIf cfg.devices.modem (with pkgs; [
        minicom         # 串口通信
        picocom         # 简单串口工具
      ]))
    ];
    
    # udev 设备规则
    services.udev.extraRules = ''
      # USB 音频设备权限
      ${lib.optionalString cfg.devices.audio ''
      SUBSYSTEM=="sound", GROUP="audio", MODE="0664"
      ''}
      
      # USB 视频设备权限
      ${lib.optionalString cfg.devices.video ''
      SUBSYSTEM=="video4linux", GROUP="video", MODE="0664"
      ''}
      
      # USB HID 设备权限
      ${lib.optionalString cfg.devices.hid ''
      SUBSYSTEM=="hidraw", GROUP="input", MODE="0664"
      ''}
    '';
  };
}
