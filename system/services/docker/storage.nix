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
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "docker-storage-cleanup" ''
        #!/bin/bash
        echo "Docker 存储清理..."
        
        echo "清理未使用的镜像..."
        docker image prune -f
        
        echo "清理未使用的容器..."
        docker container prune -f
        
        echo "清理未使用的数据卷..."
        docker volume prune -f
        
        echo "清理未使用的网络..."
        docker network prune -f
        
        echo "存储清理完成"
        docker system df
      '')
    ];
  };
}
