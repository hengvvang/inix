{ config, lib, pkgs, ... }:

{
  # OneDrive 客户端实现
  config = lib.mkIf (config.mySystem.services.sync.cloud.enable && config.mySystem.services.sync.cloud.onedrive.enable) {
    environment.systemPackages = with pkgs; [
      onedrive
    ];
    
    # 自动启动服务
    systemd.user.services.onedrive = lib.mkIf config.mySystem.services.sync.cloud.onedrive.autoStart {
      description = "OneDrive 客户端";
      wantedBy = [ "default.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.onedrive}/bin/onedrive --monitor";
        Restart = "always";
        RestartSec = 10;
      };
    };
    
    # OneDrive 工具
    environment.systemPackages = with pkgs; [
      onedrive
    ];
  };
}
