{ config, lib, pkgs, ... }:

{
  # Dropbox 客户端实现
  config = lib.mkIf (config.mySystem.services.sync.cloud.enable && config.mySystem.services.sync.cloud.dropbox.enable) {
    environment.systemPackages = with pkgs; [
      dropbox
      dropbox-cli
    ];
    
    # 自动启动服务
    systemd.user.services.dropbox = lib.mkIf config.mySystem.services.sync.cloud.dropbox.autoStart {
      description = "Dropbox 客户端";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.dropbox}/bin/dropbox";
        Restart = "always";
        RestartSec = 10;
        Environment = "QT_PLUGIN_PATH=/run/current-system/sw/lib/qt-5.15.2/plugins";
      };
    };
    
    # Dropbox 管理脚本
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "dropbox-status" ''
        #!/bin/bash
        ${pkgs.dropbox-cli}/bin/dropbox-cli status
      '')
      
      (pkgs.writeShellScriptBin "dropbox-control" ''
        #!/bin/bash
        case "$1" in
          start)
            ${pkgs.dropbox-cli}/bin/dropbox-cli start
            ;;
          stop)
            ${pkgs.dropbox-cli}/bin/dropbox-cli stop
            ;;
          status)
            ${pkgs.dropbox-cli}/bin/dropbox-cli status
            ;;
          *)
            echo "用法: dropbox-control {start|stop|status}"
            ;;
        esac
      '')
    ];
  };
}
