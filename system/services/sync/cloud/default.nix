{ config, lib, pkgs, ... }:

{
  # 云存储同步模块的完整选项定义
  options.mySystem.services.sync.cloud = {
    enable = lib.mkEnableOption "云存储同步基础支持";
    
    # === Nextcloud 选项 ===
    nextcloud = {
      enable = lib.mkEnableOption "Nextcloud 客户端";
      autoStart = lib.mkEnableOption "自动启动" // { default = true; };
    };
    
    # === OneDrive 选项 ===
    onedrive = {
      enable = lib.mkEnableOption "OneDrive 客户端";
      autoStart = lib.mkEnableOption "自动启动";
    };
    
    # === Dropbox 选项 ===
    dropbox = {
      enable = lib.mkEnableOption "Dropbox 客户端";
      autoStart = lib.mkEnableOption "自动启动";
    };
    
    # === Google Drive 选项 ===
    googledrive = {
      enable = lib.mkEnableOption "Google Drive 客户端";
      tool = lib.mkOption {
        type = lib.types.enum [ "rclone" "insync" ];
        default = "rclone";
        description = "使用的 Google Drive 工具";
      };
    };
    
    # === 通用 rclone 选项 ===
    rclone = {
      enable = lib.mkEnableOption "Rclone 通用云存储工具";
      gui = lib.mkEnableOption "Rclone Web GUI";
    };
  };

  imports = [
    ./nextcloud.nix     # Nextcloud 客户端
    ./onedrive.nix      # OneDrive 客户端
    ./dropbox.nix       # Dropbox 客户端
    ./googledrive.nix   # Google Drive 客户端
    ./rclone.nix        # Rclone 通用工具
  ];
}
