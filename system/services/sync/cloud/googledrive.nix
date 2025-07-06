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
