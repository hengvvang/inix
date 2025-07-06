{ config, lib, pkgs, ... }:

{
  options.mySystem.services.docker = {
    enable = lib.mkEnableOption "Docker 容器服务";
    compose.enable = lib.mkEnableOption "Docker Compose 支持";
    buildkit.enable = lib.mkEnableOption "Docker Buildkit 构建器";
    registry.enable = lib.mkEnableOption "本地 Docker Registry";
    monitoring.enable = lib.mkEnableOption "Docker 监控和日志";
    security.enable = lib.mkEnableOption "Docker 安全增强配置";
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
