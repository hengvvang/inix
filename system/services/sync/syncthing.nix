{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.sync.syncthing.enable {
    # Syncthing 核心服务
    services.syncthing = {
      enable = true;
      user = "hengvvang";  # 用实际用户名
      dataDir = "/home/hengvvang/.config/syncthing";
      configDir = "/home/hengvvang/.config/syncthing";
      
      # Web GUI 配置
      guiAddress = lib.mkIf config.mySystem.services.sync.syncthing.gui.enable "127.0.0.1:8384";
      openDefaultPorts = true;
    };

    # Web 管理界面配置
    networking.firewall = lib.mkIf config.mySystem.services.sync.syncthing.gui.enable {
      allowedTCPPorts = [ 8384 ];  # Web GUI
    };

    # 全局发现和中继配置
    services.syncthing.settings = lib.mkIf config.mySystem.services.sync.syncthing.discovery.enable {
      options = {
        globalAnnounceEnabled = true;
        localAnnounceEnabled = true;
        relaysEnabled = true;
      };
    };

    # 预配置常用文件夹
    services.syncthing.settings = lib.mkIf config.mySystem.services.sync.syncthing.folders.enable {
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
    };

    # 确保用户权限
    users.users.hengvvang.extraGroups = [ "syncthing" ];
    
    # 系统包
    environment.systemPackages = with pkgs; [
      syncthing
      syncthing-tray  # 系统托盘图标
    ];
  };
}
