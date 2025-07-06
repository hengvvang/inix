{ config, lib, pkgs, ... }:

{
  # Nextcloud 客户端实现
  config = lib.mkIf (config.mySystem.services.sync.cloud.enable && config.mySystem.services.sync.cloud.nextcloud.enable) {
    environment.systemPackages = with pkgs; [
      nextcloud-client
    ];
    
    # 自动启动服务
    systemd.user.services.nextcloud-client = lib.mkIf config.mySystem.services.sync.cloud.nextcloud.autoStart {
      description = "Nextcloud 客户端";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.nextcloud-client}/bin/nextcloud";
        Restart = "always";
        RestartSec = 5;
      };
    };
  };
}
