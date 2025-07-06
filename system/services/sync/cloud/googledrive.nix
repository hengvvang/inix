{ config, lib, pkgs, ... }:

{
  # Google Drive 客户端实现
  config = lib.mkMerge [
    # 使用 Rclone
    (lib.mkIf (config.mySystem.services.sync.cloud.enable && 
               config.mySystem.services.sync.cloud.googledrive.enable && 
               config.mySystem.services.sync.cloud.googledrive.tool == "rclone") {
      environment.systemPackages = with pkgs; [
        rclone
      ];
      
      # Google Drive rclone 配置脚本
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "gdrive-setup" ''
          #!/bin/bash
          echo "配置 Google Drive..."
          ${pkgs.rclone}/bin/rclone config
          echo "配置完成后，使用 'rclone sync gdrive: ~/GoogleDrive' 同步"
        '')
        
        (pkgs.writeShellScriptBin "gdrive-sync" ''
          #!/bin/bash
          REMOTE="''${1:-gdrive:}"
          LOCAL="''${2:-$HOME/GoogleDrive}"
          
          echo "同步 Google Drive: $REMOTE -> $LOCAL"
          ${pkgs.rclone}/bin/rclone sync "$REMOTE" "$LOCAL" -P
        '')
      ];
    })
    
    # 使用 Insync
    (lib.mkIf (config.mySystem.services.sync.cloud.enable && 
               config.mySystem.services.sync.cloud.googledrive.enable && 
               config.mySystem.services.sync.cloud.googledrive.tool == "insync") {
      environment.systemPackages = with pkgs; [
        insync
      ];
      
      # Insync 自动启动
      systemd.user.services.insync = {
        description = "Insync Google Drive 客户端";
        wantedBy = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.insync}/bin/insync start --no-daemon";
          Restart = "always";
          RestartSec = 10;
        };
      };
    })
  ];
}
