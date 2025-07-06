{ config, lib, pkgs, ... }:

{
  # Docker 网络配置实现
  config = lib.mkIf config.mySystem.services.docker.enable {
    # 基础网络配置
    virtualisation.docker.daemon.settings = lib.mkMerge [
      # 桥接网络
      (lib.mkIf config.mySystem.services.docker.network.bridge {
        bridge = "docker0";
      })
      
      # IPv6 支持
      (lib.mkIf config.mySystem.services.docker.network.ipv6 {
        ipv6 = true;
        "fixed-cidr-v6" = "2001:db8:1::/64";
      })
    ];
    
    # 网络工具
    environment.systemPackages = with pkgs; [
      bridge-utils      # 桥接工具
    ];
    
    # 防火墙配置
    networking.firewall = {
      trustedInterfaces = [ "docker0" ];
    };
  };
}
