{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # 基础云存储工具
    (lib.mkIf config.mySystem.services.sync.cloud.enable {
      environment.systemPackages = with pkgs; [
        rclone      # 通用云存储工具
        rclone-browser  # 图形界面
      ];
    })

    # Rclone 增强配置
    (lib.mkIf config.mySystem.services.sync.cloud.rclone.enable {
      environment.systemPackages = with pkgs; [
        rclone
        rclone-browser
        fuse  # 用于挂载云存储
      ];
      
      # 启用 FUSE 支持
      programs.fuse.userAllowOther = true;
      
      # 创建挂载点目录
      systemd.tmpfiles.rules = [
        "d /home/hengvvang/Cloud 0755 hengvvang users -"
        "d /home/hengvvang/Cloud/GoogleDrive 0755 hengvvang users -"
        "d /home/hengvvang/Cloud/OneDrive 0755 hengvvang users -"
        "d /home/hengvvang/Cloud/Dropbox 0755 hengvvang users -"
      ];
    })

    # Dropbox 官方客户端
    (lib.mkIf config.mySystem.services.sync.cloud.dropbox.enable {
      environment.systemPackages = with pkgs; [
        dropbox
        dropbox-cli
      ];
      
      # Dropbox 服务
      systemd.user.services.dropbox = {
        description = "Dropbox";
        wantedBy = [ "graphical-session.target" ];
        environment = {
          QT_PLUGIN_PATH = "/run/current-system/sw/lib/qt-5.15.5/plugins";
          QML2_IMPORT_PATH = "/run/current-system/sw/lib/qt-5.15.5/qml";
        };
        serviceConfig = {
          ExecStart = "${pkgs.dropbox}/bin/dropbox";
          ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
          KillMode = "control-group";
          Restart = "on-failure";
          PrivateTmp = true;
          ProtectSystem = "full";
          Nice = 10;
        };
      };
    })

    # OneDrive 同步
    (lib.mkIf config.mySystem.services.sync.cloud.onedrive.enable {
      environment.systemPackages = with pkgs; [
        onedrive
      ];
      
      # OneDrive 用户服务
      systemd.user.services.onedrive = {
        description = "OneDrive Free Client";
        wantedBy = [ "default.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.onedrive}/bin/onedrive --monitor";
          Restart = "on-failure";
          RestartSec = 3;
          RestartPreventExitStatus = 3;
        };
      };
    })
  ];
}
