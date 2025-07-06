{ config, lib, pkgs, ... }:

{
  # Docker 编排工具实现
  config = lib.mkMerge [
    # Docker Compose
    (lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.orchestration.compose) {
      environment.systemPackages = with pkgs; [
        docker-compose
      ];
    })
    
    # Docker Swarm 模式
    (lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.orchestration.swarm) {
      # Swarm 相关工具
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "docker-swarm-init" ''
          #!/bin/bash
          echo "初始化 Docker Swarm 集群..."
          docker swarm init
          echo "获取加入集群的命令:"
          docker swarm join-token worker
        '')
      ];
    })
    
    # Kubernetes 集成
    (lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.orchestration.kubernetes) {
      environment.systemPackages = with pkgs; [
        kubectl
        kubernetes-helm
      ];
    })
  ];
}
