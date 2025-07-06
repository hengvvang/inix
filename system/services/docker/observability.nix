{ config, lib, pkgs, ... }:

{
  # Docker 监控和日志实现
  config = lib.mkMerge [
    # 容器监控
    (lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.observability.monitoring) {
      # Portainer 容器管理界面
      virtualisation.oci-containers.containers.portainer = {
        image = "portainer/portainer-ce:latest";
        ports = [ "9443:9443" ];
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "portainer_data:/data"
        ];
        cmd = [ "--bind" ":9443" "--https" ];
      };
      
      environment.systemPackages = with pkgs; [
        ctop              # 容器监控工具
        dive              # Docker 镜像分析
      ];
    })
    
    # 集中化日志管理
    (lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.observability.logging) {
      virtualisation.docker.daemon.settings = {
        log-driver = "json-file";
        log-opts = {
          max-size = "10m";
          max-file = "3";
        };
      };
    })
    
    # 指标收集
    (lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.observability.metrics) {
      # cAdvisor 容器指标收集
      virtualisation.oci-containers.containers.cadvisor = {
        image = "gcr.io/cadvisor/cadvisor:latest";
        ports = [ "8080:8080" ];
        volumes = [
          "/:/rootfs:ro"
          "/var/run:/var/run:ro"
          "/sys:/sys:ro"
          "/var/lib/docker/:/var/lib/docker:ro"
          "/dev/disk/:/dev/disk:ro"
        ];
      };
    })
  ];
}
