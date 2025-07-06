{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.syncthing.enable {
    # Syncthing 文件同步服务配置
    services.syncthing = {
      enable = true;
      user = "hengvvang";
      dataDir = "/home/hengvvang/Sync";
      configDir = "/home/hengvvang/.config/syncthing";
      
      # Web GUI 配置
      guiAddress = "127.0.0.1:8384";
      openDefaultPorts = true;
      
      # 基本设置
      settings = {
        options = {
          globalAnnounceEnabled = true;
          localAnnounceEnabled = true;
          relaysEnabled = true;
          natEnabled = true;
          urAccepted = -1; # 禁用使用情况报告
        };
        
        # 默认文件夹配置
        folders = {
          "Documents" = {
            path = "/home/hengvvang/Documents";
            devices = [ ]; # 需要手动添加设备
            versioning = {
              type = "simple";
              params.keep = "10";
            };
          };
        };
      };
    };

    # 确保同步目录存在且权限正确
    systemd.tmpfiles.rules = [
      "d /home/hengvvang/Sync 0755 hengvvang users -"
      "d /home/hengvvang/.config/syncthing 0700 hengvvang users -"
    ];

    # 防火墙配置
    networking.firewall = {
      allowedTCPPorts = [ 8384 22000 ];
      allowedUDPPorts = [ 22000 21027 ];
    };
  };
}
