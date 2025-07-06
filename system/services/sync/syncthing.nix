{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.sync.enable && config.mySystem.services.sync.syncthing.enable) {
    # Syncthing 核心服务
    services.syncthing = {
      enable = true;
      user = "hengvvang";
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
