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
      (writeShellScriptBin "docker-registry-manager" ''
        #!/bin/bash
        
        REGISTRY_URL="localhost:5000"
        
        case "$1" in
          list)
            echo "Images in local registry:"
            curl -s "http://$REGISTRY_URL/v2/_catalog" | ${jq}/bin/jq .
            ;;
          tags)
            if [ -z "$2" ]; then
              echo "Usage: docker-registry-manager tags <image-name>"
              exit 1
            fi
            echo "Tags for $2:"
            curl -s "http://$REGISTRY_URL/v2/$2/tags/list" | ${jq}/bin/jq .
            ;;
          delete)
            if [ -z "$2" ] || [ -z "$3" ]; then
              echo "Usage: docker-registry-manager delete <image-name> <tag>"
              exit 1
            fi
            # 获取镜像摘要
            DIGEST=$(curl -s -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
              "http://$REGISTRY_URL/v2/$2/manifests/$3" | ${jq}/bin/jq -r '.config.digest')
            
            if [ "$DIGEST" != "null" ]; then
              curl -X DELETE "http://$REGISTRY_URL/v2/$2/manifests/$DIGEST"
              echo "Deleted $2:$3"
            else
              echo "Image not found: $2:$3"
            fi
            ;;
          gc)
            echo "Running garbage collection..."
            docker exec local-registry registry garbage-collect /etc/docker/registry/config.yml
            ;;
          push)
            if [ -z "$2" ]; then
              echo "Usage: docker-registry-manager push <image-name>"
              exit 1
            fi
            docker tag "$2" "$REGISTRY_URL/$2"
            docker push "$REGISTRY_URL/$2"
            ;;
          *)
            echo "Usage: docker-registry-manager {list|tags|delete|gc|push} [args...]"
            exit 1
            ;;
        esac
      '')
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
