{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.monitoring.enable) {
    # Docker 监控服务
    virtualisation.oci-containers.containers = {
      # cAdvisor - 容器性能监控
      cadvisor = {
        image = "gcr.io/cadvisor/cadvisor:v0.47.0";
        ports = [ "8080:8080" ];
        
        volumes = [
          "/:/rootfs:ro"
          "/var/run:/var/run:ro"
          "/sys:/sys:ro"
          "/var/lib/docker/:/var/lib/docker:ro"
          "/dev/disk/:/dev/disk:ro"
        ];
        
        extraOptions = [
          "--restart=unless-stopped"
          "--name=cadvisor"
          "--privileged"
          "--device=/dev/kmsg"
        ];
      };

      # Portainer - Docker 管理界面
      portainer = {
        image = "portainer/portainer-ce:latest";
        ports = [ "9000:9000" "9443:9443" ];
        
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "portainer_data:/data"
        ];
        
        extraOptions = [
          "--restart=unless-stopped"
          "--name=portainer"
        ];
      };
    };

    # 日志聚合配置
    services.journald.extraConfig = lib.mkIf (config.mySystem.services.docker.logDriver == "journald") ''
      # Docker 容器日志配置
      SystemMaxUse=1G
      SystemKeepFree=2G
      SystemMaxFileSize=100M
      MaxRetentionSec=1month
    '';

    # 监控数据目录
    systemd.tmpfiles.rules = [
      "d /var/lib/docker-monitoring 0755 root root -"
      "d /var/log/docker-containers 0755 root root -"
    ];

    # 防火墙配置
    networking.firewall.allowedTCPPorts = [ 8080 9000 9443 ];

    # Docker 监控和管理工具
    environment.systemPackages = with pkgs; [
      docker-compose
      ctop  # 容器实时监控
      dive  # Docker 镜像分析
      
      (writeShellScriptBin "docker-monitor" ''
        #!/bin/bash
        
        case "$1" in
          stats)
            echo "Docker 容器统计信息:"
            docker stats --no-stream
            ;;
          logs)
            if [ -z "$2" ]; then
              echo "Usage: docker-monitor logs <container-name>"
              exit 1
            fi
            docker logs -f --tail 100 "$2"
            ;;
          cleanup)
            echo "清理 Docker 资源..."
            docker system prune -f
            docker volume prune -f
            docker image prune -f
            ;;
          health)
            echo "Docker 系统健康检查:"
            docker system df
            echo ""
            echo "运行中的容器:"
            docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
            ;;
          cadvisor)
            echo "打开 cAdvisor 监控界面: http://localhost:8080"
            ;;
          portainer)
            echo "打开 Portainer 管理界面: http://localhost:9000"
            ;;
          *)
            echo "Usage: docker-monitor {stats|logs|cleanup|health|cadvisor|portainer}"
            exit 1
            ;;
        esac
      '')
    ];

    # 定期清理任务
    systemd.services.docker-cleanup = {
      description = "Docker 定期清理任务";
      
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
      
      script = ''
        # 清理悬空镜像
        ${pkgs.docker}/bin/docker image prune -f
        
        # 清理未使用的卷
        ${pkgs.docker}/bin/docker volume prune -f
        
        # 清理构建缓存
        ${pkgs.docker}/bin/docker builder prune -f --filter until=168h
        
        echo "Docker 清理完成: $(date)"
      '';
    };

    # 定期清理计时器
    systemd.timers.docker-cleanup = {
      description = "Docker 定期清理计时器";
      wantedBy = [ "timers.target" ];
      
      timerConfig = {
        OnCalendar = "weekly";
        Persistent = true;
        RandomizedDelaySec = "1h";
      };
    };
  };
}
