{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.containers.docker;
in
{
  config = lib.mkIf cfg.enable {

    virtualisation.docker = {
      package = pkgs.docker;
      enable = true;
      rootless = lib.mkIf cfg.rootless {
        enable = true;
        setSocketVariable = true;
      };
    };

    # users.users.hengvvang.extraGroups = [ "docker" ];
    users.extraGroups.docker.members = [ "hengvvang" "zlritsu"];

    # Btrfs 存储驱动配置
    virtualisation.docker.storageDriver = lib.mkIf cfg.btrfs "btrfs";

    # NVIDIA GPU 支持
    hardware.nvidia-container-toolkit.enable = lib.mkIf cfg.nvidia true;

    # 网络配置
    networking.firewall.trustedInterfaces = [ "docker0" ];

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
