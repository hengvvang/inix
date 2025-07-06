{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.registry.enable) {
    # 本地 Docker Registry 服务
    virtualisation.oci-containers.containers.registry = {
      image = "registry:2";
      ports = [ "5000:5000" ];
      
      volumes = [
        "/var/lib/docker-registry:/var/lib/registry"
        "/etc/docker/registry/config.yml:/etc/docker/registry/config.yml:ro"
      ];
      
      environment = {
        REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY = "/var/lib/registry";
        REGISTRY_HTTP_ADDR = "0.0.0.0:5000";
      };
      
      extraOptions = [
        "--restart=unless-stopped"
        "--name=local-registry"
      ];
    };

    # Registry 配置文件
    environment.etc."docker/registry/config.yml".text = ''
      version: 0.1
      log:
        level: info
        fields:
          service: registry
      
      storage:
        filesystem:
          rootdirectory: /var/lib/registry
        delete:
          enabled: true
      
      http:
        addr: :5000
        relativeurls: false
        draintimeout: 60s
      
      health:
        storagedriver:
          enabled: true
          interval: 10s
          threshold: 3
    '';

    # Registry 数据目录
    systemd.tmpfiles.rules = [
      "d /var/lib/docker-registry 0755 root root -"
      "d /etc/docker/registry 0755 root root -"
    ];

    # 防火墙配置
    networking.firewall.allowedTCPPorts = [ 5000 ];

    # Registry 管理工具
    environment.systemPackages = with pkgs; [
      docker    # Docker CLI 包含注册表管理功能
      curl      # API 调用工具
      jq        # JSON 处理工具
    ];

    # Docker 配置，信任本地 registry
    environment.etc."docker/daemon.json".text = lib.mkIf config.mySystem.services.docker.enable ''
      {
        "insecure-registries": ["localhost:5000", "127.0.0.1:5000"],
        "registry-mirrors": []
      }
    '';
  };
}
