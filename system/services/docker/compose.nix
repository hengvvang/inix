{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.compose.enable) {
    # Docker Compose 支持
    environment.systemPackages = with pkgs; [
      docker-compose
      
      # V2 Compose 插件（推荐）
      docker-buildx
    ];

    # Compose 项目目录
    systemd.tmpfiles.rules = [
      "d /opt/docker-compose 0755 root root -"
      "d /opt/docker-compose/projects 0755 root root -"
      "d /opt/docker-compose/configs 0755 root root -"
    ];

    # 全局 Compose 配置
    environment.etc."docker/compose.yml".text = ''
      version: '3.8'
      
      # 全局网络配置
      networks:
        default:
          driver: bridge
          ipam:
            config:
              - subnet: 172.20.0.0/16
        
        frontend:
          driver: bridge
          
        backend:
          driver: bridge
          internal: true
      
      # 全局卷配置
      volumes:
        portainer_data:
          driver: local
        
        shared_data:
          driver: local
          driver_opts:
            type: none
            o: bind
            device: /opt/docker-compose/shared
    '';

    # Compose 辅助脚本
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "docker-compose-manager" ''
        #!/bin/bash
        
        COMPOSE_DIR="/opt/docker-compose/projects"
        
        case "$1" in
          list)
            echo "Available Docker Compose projects:"
            ls -la "$COMPOSE_DIR"
            ;;
          up)
            if [ -z "$2" ]; then
              echo "Usage: docker-compose-manager up <project-name>"
              exit 1
            fi
            cd "$COMPOSE_DIR/$2" && docker-compose up -d
            ;;
          down)
            if [ -z "$2" ]; then
              echo "Usage: docker-compose-manager down <project-name>"
              exit 1
            fi
            cd "$COMPOSE_DIR/$2" && docker-compose down
            ;;
          logs)
            if [ -z "$2" ]; then
              echo "Usage: docker-compose-manager logs <project-name>"
              exit 1
            fi
            cd "$COMPOSE_DIR/$2" && docker-compose logs -f
            ;;
          *)
            echo "Usage: docker-compose-manager {list|up|down|logs} [project-name]"
            exit 1
            ;;
        esac
      '')
    ];
  };
}
