{ config, lib, pkgs, ... }:

{
  # Rclone 通用云存储工具实现
  config = lib.mkIf (config.mySystem.services.sync.cloud.enable && config.mySystem.services.sync.cloud.rclone.enable) {
    environment.systemPackages = with pkgs; [
      rclone
      rclone-browser  # GUI 浏览器
    ];
    
    # Rclone Web GUI 服务
    systemd.user.services.rclone-gui = lib.mkIf config.mySystem.services.sync.cloud.rclone.gui {
      description = "Rclone Web GUI";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.rclone}/bin/rclone rcd --rc-web-gui --rc-addr=127.0.0.1:5572";
        Restart = "always";
        RestartSec = 10;
      };
    };
    
    # Rclone 管理脚本
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "rclone-mount" ''
        #!/bin/bash
        if [ $# -lt 2 ]; then
          echo "用法: rclone-mount <远程名称> <本地挂载点>"
          echo "示例: rclone-mount gdrive: ~/GoogleDrive"
          exit 1
        fi
        
        REMOTE="$1"
        MOUNT_POINT="$2"
        
        mkdir -p "$MOUNT_POINT"
        ${pkgs.rclone}/bin/rclone mount "$REMOTE" "$MOUNT_POINT" \
          --vfs-cache-mode writes \
          --daemon
        
        echo "已挂载 $REMOTE 到 $MOUNT_POINT"
      '')
      
      (pkgs.writeShellScriptBin "rclone-unmount" ''
        #!/bin/bash
        if [ $# -lt 1 ]; then
          echo "用法: rclone-unmount <挂载点>"
          exit 1
        fi
        
        MOUNT_POINT="$1"
        fusermount -u "$MOUNT_POINT"
        echo "已卸载 $MOUNT_POINT"
      '')
      
      (pkgs.writeShellScriptBin "rclone-backup" ''
        #!/bin/bash
        if [ $# -lt 2 ]; then
          echo "用法: rclone-backup <本地路径> <远程路径>"
          echo "示例: rclone-backup ~/Documents gdrive:Backup/Documents"
          exit 1
        fi
        
        LOCAL="$1"
        REMOTE="$2"
        
        echo "备份 $LOCAL 到 $REMOTE..."
        ${pkgs.rclone}/bin/rclone sync "$LOCAL" "$REMOTE" \
          --progress \
          --transfers 4 \
          --checkers 8 \
          --stats 1s
      '')
    ];
    
    # FUSE 支持 (用于挂载)
    programs.fuse.userAllowOther = true;
  };
}
