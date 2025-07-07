{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.usb;
in
{
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

  imports = [
    ./security.nix
  ];

  config = lib.mkIf cfg.enable {
    # USB 核心支持
    boot.kernelModules = [
      "usb_storage"      # USB 存储
      "usbhid"          # USB HID 设备
      "usbserial"       # USB 串口设备
    ];

    # 热插拔支持
    services.udev.enable = true;
    services.udisks2.enable = cfg.automount;

    # 文件系统支持
    boot.supportedFilesystems = lib.optionals cfg.filesystems [
      "ntfs"            # NTFS (Windows)
      "exfat"           # exFAT (跨平台)
      "vfat"            # FAT32
      "ext2" "ext3" "ext4"  # Linux 文件系统
    ];

    # 文件系统工具
    environment.systemPackages = with pkgs; lib.optionals cfg.filesystems [
      ntfs3g            # NTFS 支持
      exfat             # exFAT 支持
      dosfstools        # FAT 工具
      e2fsprogs         # ext 工具
    ]
    # USB 音频设备
    ++ lib.optionals cfg.devices.audio [
      alsa-utils        # ALSA 工具
      pulseaudio        # 音频服务
    ]
    # USB 视频设备  
    ++ lib.optionals cfg.devices.video [
      v4l-utils         # Video4Linux 工具
      ffmpeg            # 视频处理
    ]
    # 管理工具
    ++ lib.optionals cfg.tools [
      usbutils          # lsusb, usb-devices
      pciutils          # lspci
      lshw              # 硬件信息
    ];

    # USB 设备权限
    services.udev.extraRules = ''
      # USB 存储设备权限
      SUBSYSTEM=="usb", ATTR{bDeviceClass}=="08", GROUP="users", MODE="0664"
      # USB HID 设备权限  
      SUBSYSTEM=="usb", ATTR{bInterfaceClass}=="03", GROUP="users", MODE="0664"
    '';

    # 音频设备支持
    services.pipewire = lib.mkIf cfg.devices.audio {
      enable = true;
      alsa.enable = true;
    };
  };
}
