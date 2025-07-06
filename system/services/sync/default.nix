{ config, lib, pkgs, ... }:

{
  options.mySystem.services.sync = {
    # Syncthing 点对点文件同步
    syncthing = {
      enable = lib.mkEnableOption "Syncthing 文件同步服务";
      gui.enable = lib.mkEnableOption "Syncthing Web 管理界面";
      discovery.enable = lib.mkEnableOption "全局发现和中继";
      folders.enable = lib.mkEnableOption "预配置常用同步文件夹";
    };
    
    # 云存储同步
    cloud = {
      enable = lib.mkEnableOption "云存储同步工具";
      rclone.enable = lib.mkEnableOption "Rclone 多云存储同步";
      dropbox.enable = lib.mkEnableOption "Dropbox 官方客户端";
      onedrive.enable = lib.mkEnableOption "OneDrive 同步工具";
    };
    
    # 备份服务
    backup = {
      enable = lib.mkEnableOption "本地备份服务";
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
