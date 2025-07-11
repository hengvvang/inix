{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.containers.docker;
in
{
  # Docker 服务实现
  config = lib.mkIf cfg.enable {
    # 核心 Docker 服务
    virtualisation.docker = {
      enable = true;
      rootless = lib.mkIf cfg.rootless {
        enable = true;
        setSocketVariable = true;
      };
    };

    # 用户配置
    users.users.hengvvang.extraGroups = [ "docker" ];

    # 系统工具包
    environment.systemPackages = with pkgs; [
      docker
    ] ++ lib.optionals cfg.compose [
      docker-compose
    ] ++ lib.optionals cfg.monitoring [
      ctop
      dive
      lazydocker
    ] ++ lib.optionals cfg.nvidia [
      nvidia-docker
    ];

    # NVIDIA GPU 支持
    virtualisation.docker.enableNvidia = lib.mkIf cfg.nvidia true;

    # 网络配置
    networking.firewall.trustedInterfaces = [ "docker0" ];
    
    # Docker daemon 配置优化
    virtualisation.docker.daemon.settings = {
      "log-driver" = "json-file";
      "log-opts" = {
        "max-size" = "10m";
        "max-file" = "3";
      };
      "experimental" = true;
      "features" = {
        "buildkit" = true;
      };
    };

    # 本地 Docker Registry
    services.dockerRegistry = lib.mkIf cfg.registry.enable {
      enable = true;
      port = cfg.registry.port;
      listenAddress = "0.0.0.0";
    };

    # 防火墙配置
    networking.firewall.allowedTCPPorts = lib.optionals cfg.registry.enable [ cfg.registry.port ];
  };
}
