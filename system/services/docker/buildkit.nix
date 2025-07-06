{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.buildkit.enable) {
    # Buildkit 工具
    environment.systemPackages = with pkgs; [
      docker-buildx
      buildkit
    ];

    # Buildkit 配置
    virtualisation.docker.daemon.settings = lib.mkIf config.mySystem.services.docker.enable {
      features = {
        buildkit = true;
      };
      
      # 构建器配置
      builder = {
        gc = {
          enabled = true;
          defaultKeepStorage = "20GB";
          policy = [
            { keepStorage = "10GB"; filter = [ "unused-for=24h" ]; }
            { keepStorage = "50GB"; filter = [ "unused-for=168h" ]; }
            { keepStorage = "100GB"; all = true; }
          ];
        };
      };
    };

    # 多架构构建支持
    boot.binfmt.emulatedSystems = [ 
      "aarch64-linux" 
      "armv7l-linux" 
      "riscv64-linux"
    ];

    # Buildx 构建器配置脚本
    systemd.services.docker-buildx-setup = {
      description = "Setup Docker Buildx builder";
      after = [ "docker.service" ];
      wantedBy = [ "multi-user.target" ];
      
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = "root";
      };
      
      script = ''
        # 等待 Docker 服务启动
        while ! ${pkgs.docker}/bin/docker info >/dev/null 2>&1; do
          sleep 1
        done
        
        # 创建多架构构建器
        if ! ${pkgs.docker-buildx}/bin/docker buildx inspect multiarch >/dev/null 2>&1; then
          ${pkgs.docker-buildx}/bin/docker buildx create \
            --name multiarch \
            --driver docker-container \
            --use
          
          ${pkgs.docker-buildx}/bin/docker buildx inspect multiarch --bootstrap
        fi
        
        # 设置为默认构建器
        ${pkgs.docker-buildx}/bin/docker buildx use multiarch
      '';
    };
  };
}
