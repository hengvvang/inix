{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.sync.enable && config.mySystem.services.sync.syncthing.enable) {
    # Syncthing 核心服务
    services.syncthing = {
      enable = true;
      user = "hengvvang";  # 用实际用户名
      dataDir = "/home/hengvvang/.config/syncthing";
      configDir = "/home/hengvvang/.config/syncthing";
      
      # Web GUI 配置
      guiAddress = "127.0.0.1:8384";
      openDefaultPorts = true;
    };

    # 网络配置
    networking.firewall = {
      allowedTCPPorts = [ 8384 22000 ];  # Web GUI and sync
      allowedUDPPorts = [ 22000 21027 ]; # Discovery
    };

    # 用户组配置
    users.users.hengvvang.extraGroups = [ "syncthing" ];
  };
}
      })
      
      # 预配置常用文件夹
      (lib.mkIf config.mySystem.services.sync.syncthing.folders.enable {
        folders = {
          "Documents" = {
            path = "/home/hengvvang/Documents";
            devices = [ ];  # 需要在 GUI 中添加设备
          };
          "Pictures" = {
            path = "/home/hengvvang/Pictures";
            devices = [ ];
          };
        };
      })
    ];

    # 确保用户权限
    users.users.hengvvang.extraGroups = [ "syncthing" ];
    
    # 系统包
    environment.systemPackages = with pkgs; [
      syncthing
      syncthing-tray  # 系统托盘图标
    ];
  };
}
