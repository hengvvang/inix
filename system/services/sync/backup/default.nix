{ config, lib, pkgs, ... }:

{
  # 备份工具模块的完整选项定义
  options.mySystem.services.sync.backup = {
    enable = lib.mkEnableOption "备份工具基础支持";
    
    # === 传统备份工具选项 ===
    traditional = {
      rsync = lib.mkEnableOption "Rsync 同步备份" // { default = true; };
      tar = lib.mkEnableOption "TAR 归档备份";
    };
    
    # === 现代备份工具选项 ===
    modern = {
      restic = lib.mkEnableOption "Restic 增量备份";
      borg = lib.mkEnableOption "Borg 去重备份";
      rclone = lib.mkEnableOption "Rclone 云备份";
    };
  };

  # 备份工具实现
  config = lib.mkIf config.mySystem.services.sync.backup.enable {
    # 传统备份工具
    environment.systemPackages = lib.optionals config.mySystem.services.sync.backup.traditional.rsync (with pkgs; [
      rsync
    ]) ++ lib.optionals config.mySystem.services.sync.backup.traditional.tar (with pkgs; [
      gnutar
      gzip
      bzip2
    ]) ++ lib.optionals config.mySystem.services.sync.backup.modern.restic (with pkgs; [
      restic
    ]) ++ lib.optionals config.mySystem.services.sync.backup.modern.borg (with pkgs; [
      borgbackup
    ]) ++ lib.optionals config.mySystem.services.sync.backup.modern.rclone (with pkgs; [
      rclone
    ]);
  };
}
