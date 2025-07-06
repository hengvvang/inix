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
      # Swarm 工具 (Docker CLI 已包含)
      environment.systemPackages = with pkgs; [
        docker
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
