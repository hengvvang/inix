{ config, lib, pkgs, ... }:

{
  # 备份工具模块的完整选项定义
  options.mySystem.services.sync.backup = {
    enable = lib.mkEnableOption "备份工具基础支持";
    
    # === 传统备份工具选项 ===
    traditional = {
      rsync = lib.mkEnableOption "Rsync 同步备份" // { default = true; };
      tar = lib.mkEnableOption "TAR 归档备份";
      dd = lib.mkEnableOption "DD 磁盘备份";
    };
    
    # === 现代备份工具选项 ===
    modern = {
      restic = lib.mkEnableOption "Restic 增量备份";
      borg = lib.mkEnableOption "Borg 去重备份";
      duplicity = lib.mkEnableOption "Duplicity 加密备份";
      rclone = lib.mkEnableOption "Rclone 云备份";
    };
    
    # === 数据库备份选项 ===
    database = {
      mysql = lib.mkEnableOption "MySQL 数据库备份";
      postgresql = lib.mkEnableOption "PostgreSQL 数据库备份";
      sqlite = lib.mkEnableOption "SQLite 数据库备份";
    };
    
    # === 自动化选项 ===
    automation = {
      cron = lib.mkEnableOption "定时备份任务";
      systemd = lib.mkEnableOption "Systemd 定时器备份";
      monitoring = lib.mkEnableOption "备份状态监控";
    };
  };

  imports = [
    ./traditional.nix  # 传统备份工具
    ./modern.nix       # 现代备份工具
    ./database.nix     # 数据库备份
    ./automation.nix   # 自动化备份
  ];
}
