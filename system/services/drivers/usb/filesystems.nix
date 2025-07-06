{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.usb;
in
{
  config = lib.mkIf cfg.enable {
    # NTFS 文件系统支持
    boot.supportedFilesystems = lib.optionals cfg.filesystems.ntfs [ "ntfs" ];
    environment.systemPackages = lib.optionals cfg.filesystems.ntfs (with pkgs; [
      ntfs3g
      ntfsprogs
    ]);
    
    # exFAT 文件系统支持
    boot.supportedFilesystems = lib.optionals cfg.filesystems.exfat [ "exfat" ];
    environment.systemPackages = lib.optionals cfg.filesystems.exfat (with pkgs; [
      exfat
      exfatprogs
    ]);
    
    # FAT32 文件系统支持
    boot.supportedFilesystems = lib.optionals cfg.filesystems.fat32 [ "vfat" ];
    environment.systemPackages = lib.optionals cfg.filesystems.fat32 (with pkgs; [
      dosfstools
    ]);
    
    # ext2/3/4 文件系统支持
    boot.supportedFilesystems = lib.optionals cfg.filesystems.ext [ "ext2" "ext3" "ext4" ];
    environment.systemPackages = lib.optionals cfg.filesystems.ext (with pkgs; [
      e2fsprogs
    ]);
    
    # 文件系统工具
    environment.systemPackages = with pkgs; [
      file              # 文件类型检测
      parted            # 分区工具
    ] ++ lib.optionals (cfg.filesystems.ntfs || cfg.filesystems.exfat || cfg.filesystems.fat32) [
      gparted           # 图形分区工具
    ];
    
    # 自动挂载配置
    services.udisks2.settings = {
      "mount-options.conf" = lib.mkIf cfg.filesystems.ntfs {
        ntfs_defaults = "uid=1000,gid=100,dmask=022,fmask=133";
      };
    };
  };
}
  };
}
