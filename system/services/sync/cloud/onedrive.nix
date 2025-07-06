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
    
    # 配置管理脚本
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "onedrive-setup" ''
        #!/bin/bash
        echo "OneDrive 初始设置..."
        ${pkgs.onedrive}/bin/onedrive --display-config
        echo "运行 'onedrive --synchronize' 进行首次同步"
        echo "然后启用自动同步服务"
      '')
    ];
  };
}
