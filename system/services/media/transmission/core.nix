{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.media.transmission.enable {
    # Transmission BitTorrent 客户端配置
    services.transmission = {
      enable = true;
      openRPCPort = true;
      openPeerPorts = true;
      
      # 基本配置
      settings = {
        # 下载配置
        download-dir = "/var/lib/transmission/Downloads";
        incomplete-dir = "/var/lib/transmission/Incomplete";
        incomplete-dir-enabled = true;
        
        # 网络配置
        peer-port = 51413;
        rpc-bind-address = "0.0.0.0";
        rpc-port = 9091;
        rpc-authentication-required = false;
        
        # 速度限制
        speed-limit-down-enabled = false;
        speed-limit-up-enabled = false;
        
        # 连接配置
        peer-limit-global = 200;
        peer-limit-per-torrent = 50;
        
        # 文件权限
        umask = 2;
      };
    };

    # 确保下载目录存在且权限正确
    systemd.tmpfiles.rules = [
      "d /var/lib/transmission/Downloads 0755 transmission transmission -"
      "d /var/lib/transmission/Incomplete 0755 transmission transmission -"
    ];
  };
}
