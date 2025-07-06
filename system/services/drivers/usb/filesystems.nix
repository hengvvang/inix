{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.usb;
in
{
  config = lib.mkIf cfg.enable {
    # 文件系统支持合并
    boot.supportedFilesystems = lib.flatten [
      (lib.optionals cfg.filesystems.ntfs [ "ntfs" ])
      (lib.optionals cfg.filesystems.exfat [ "exfat" ])
      (lib.optionals cfg.filesystems.fat32 [ "vfat" ])
      (lib.optionals cfg.filesystems.ext [ "ext2" "ext3" "ext4" ])
    ];
    
    # 文件系统工具软件包
    environment.systemPackages = lib.flatten [
      # NTFS 文件系统工具
      (lib.optionals cfg.filesystems.ntfs (with pkgs; [
        ntfs3g
        ntfsprogs
      ]))
      # exFAT 文件系统工具
      (lib.optionals cfg.filesystems.exfat (with pkgs; [
        exfat
        exfatprogs
      ]))
      # FAT32 文件系统工具
      (lib.optionals cfg.filesystems.fat32 (with pkgs; [
        dosfstools
      ]))
      # ext2/3/4 文件系统工具
      (lib.optionals cfg.filesystems.ext (with pkgs; [
        e2fsprogs
      ]))
      # 通用文件系统工具
      (with pkgs; [
        file              # 文件类型检测
        parted            # 分区工具
      ])
      # 图形分区工具（如果启用了 Windows 文件系统）
      (lib.optionals (cfg.filesystems.ntfs || cfg.filesystems.exfat || cfg.filesystems.fat32) (with pkgs; [
        gparted           # 图形分区工具
      ]))
    ];
    
    # 自动挂载配置
    services.udisks2.settings = {
      "mount-options.conf" = lib.mkIf cfg.filesystems.ntfs {
        ntfs_defaults = "uid=1000,gid=100,dmask=022,fmask=133";
      };
    };
  };
}
