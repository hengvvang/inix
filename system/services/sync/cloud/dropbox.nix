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
    
    # Dropbox 工具
    environment.systemPackages = with pkgs; [
      dropbox-cli
    ];
  };
}
