{ config, lib, pkgs, ... }:

{
  # Docker 存储配置实现
  config = lib.mkIf config.mySystem.services.docker.enable {
    # 数据卷管理
    virtualisation.docker.daemon.settings = lib.mkIf config.mySystem.services.docker.storage.volumes {
      data-root = "/var/lib/docker";
    };
    
    # 本地镜像仓库
    services.dockerRegistry = lib.mkIf config.mySystem.services.docker.storage.registry {
      enable = true;
      port = 5000;
      listenAddress = "127.0.0.1";
    };
    
    # 存储管理工具
    environment.systemPackages = with pkgs; [
      docker    # Docker 命令行工具已包含存储清理功能
    ];
  };
}
