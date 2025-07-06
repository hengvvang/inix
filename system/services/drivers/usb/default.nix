{ config, lib, pkgs, ... }:

{
  # USB 设备驱动模块的完整选项定义
  options.mySystem.services.drivers.usb = {
    enable = lib.mkEnableOption "USB 设备支持";
    
    # === 核心功能选项 ===
    core = {
      storage = lib.mkEnableOption "USB 存储支持" // { default = true; };
      automount = lib.mkEnableOption "自动挂载" // { default = true; };
      hotplug = lib.mkEnableOption "热插拔支持" // { default = true; };
    };
    
    # === 设备类型选项 ===
    devices = {
      massStorage = lib.mkEnableOption "大容量存储设备" // { default = true; };
      hid = lib.mkEnableOption "HID 人机接口设备" // { default = true; };
      audio = lib.mkEnableOption "USB 音频设备";
      video = lib.mkEnableOption "USB 视频设备";
      printer = lib.mkEnableOption "USB 打印机";
      modem = lib.mkEnableOption "USB 调制解调器";
    };
    
    # === 文件系统选项 ===
    filesystems = {
      ntfs = lib.mkEnableOption "NTFS 文件系统支持" // { default = true; };
      exfat = lib.mkEnableOption "exFAT 文件系统支持" // { default = true; };
      fat32 = lib.mkEnableOption "FAT32 文件系统支持" // { default = true; };
      ext = lib.mkEnableOption "ext2/3/4 文件系统支持" // { default = true; };
    };
    
    # === 工具选项 ===
    tools = {
      management = lib.mkEnableOption "USB 管理工具" // { default = true; };
      debugging = lib.mkEnableOption "调试工具";
      security = lib.mkEnableOption "安全工具";
      benchmark = lib.mkEnableOption "性能测试工具";
    };
    
    # === 安全选项 ===
    security = {
      whitelist = lib.mkEnableOption "设备白名单";
      encryption = lib.mkEnableOption "加密存储支持";
      readonly = lib.mkEnableOption "只读模式选项";
    };
  };

  imports = [
    ./core.nix         # 核心功能
    ./devices.nix      # 设备类型
    ./filesystems.nix  # 文件系统
    ./tools.nix        # 管理工具
    ./security.nix     # 安全功能
  ];
}
