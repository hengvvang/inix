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
    
    # Rclone 工具
    environment.systemPackages = with pkgs; [
      rclone
    ];
    
    # FUSE 支持 (用于挂载)
    programs.fuse.userAllowOther = true;
  };
}
