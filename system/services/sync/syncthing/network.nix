{ config, lib, pkgs, ... }:

{
  # Syncthing 网络配置实现
  config = lib.mkIf config.mySystem.services.sync.syncthing.enable {
    # 防火墙配置
    networking.firewall = lib.mkIf config.mySystem.services.sync.syncthing.service.openFirewall {
      # Syncthing 端口
      allowedTCPPorts = [ 
        config.mySystem.services.sync.syncthing.network.listen.tcp 
      ] ++ lib.optionals config.mySystem.services.sync.syncthing.network.gui.enable [
        config.mySystem.services.sync.syncthing.network.gui.port
      ];
      
      allowedUDPPorts = [ 
        config.mySystem.services.sync.syncthing.network.listen.udp 
      ];
    };
    
    # 网络优化
    boot.kernel.sysctl = {
      # TCP 优化
      "net.core.rmem_default" = 262144;
      "net.core.rmem_max" = 16777216;
      "net.core.wmem_default" = 262144;
      "net.core.wmem_max" = 16777216;
      
      # 连接数优化
      "net.core.somaxconn" = 32768;
      "net.ipv4.tcp_max_syn_backlog" = 32768;
    };
    
    # 服务发现配置
    services.avahi = lib.mkIf config.mySystem.services.sync.syncthing.sync.localAnnounceEnabled {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
