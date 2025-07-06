{ config, lib, pkgs, ... }:

{
  options.mySystem.services.docker = {
    enable = lib.mkEnableOption "Docker 容器服务";
    
    # 细粒度配置选项
    compose.enable = lib.mkEnableOption "Docker Compose 支持";
    buildkit.enable = lib.mkEnableOption "Docker Buildkit 构建器";
    registry.enable = lib.mkEnableOption "本地 Docker Registry";
    monitoring.enable = lib.mkEnableOption "Docker 监控和日志";
    security.enable = lib.mkEnableOption "Docker 安全增强配置";
    
    # 高级配置选项
    storageDriver = lib.mkOption {
      type = lib.types.enum [ "overlay2" "btrfs" "zfs" "devicemapper" ];
      default = "overlay2";
      description = "Docker 存储驱动选择";
    };
    
    dataRoot = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/docker";
      description = "Docker 数据存储路径";
    };
    
    logDriver = lib.mkOption {
      type = lib.types.enum [ "json-file" "journald" "syslog" "none" ];
      default = "journald";
      description = "Docker 日志驱动";
    };
  };

  imports = [
    ./core.nix
    ./compose.nix
    ./buildkit.nix
    ./registry.nix
    ./monitoring.nix
    ./security.nix
  ];
}
