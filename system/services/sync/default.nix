{ config, lib, pkgs, ... }:

{
  options.mySystem.services.sync = {
    enable = lib.mkEnableOption "同步和备份服务";
    syncthing.enable = lib.mkEnableOption "Syncthing 文件同步服务";
    cloud = {
      enable = lib.mkEnableOption "云存储同步工具";
      rclone.enable = lib.mkEnableOption "Rclone 多云存储同步";
      dropbox.enable = lib.mkEnableOption "Dropbox 官方客户端";
      onedrive.enable = lib.mkEnableOption "OneDrive 同步工具";
    };
    backup = {
      enable = lib.mkEnableOption "备份工具";
      rsync.enable = lib.mkEnableOption "Rsync 增量备份";
      timeshift.enable = lib.mkEnableOption "Timeshift 系统快照";
    };
  };

  imports = [
    ./syncthing.nix
    ./cloud.nix
    ./backup.nix
  ];
}
