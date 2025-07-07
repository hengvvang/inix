{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.docker;
in
{
  # Docker 容器服务配置选项
  options.mySystem.services.docker = {
    enable = lib.mkEnableOption "Docker 容器服务支持";
    
    # 基础配置
    compose = lib.mkEnableOption "Docker Compose 编排工具" // { default = true; };
    monitoring = lib.mkEnableOption "容器监控工具" // { default = false; };
  };

  # Docker 服务实现
  config = lib.mkIf cfg.enable {
    # 核心 Docker 服务
    virtualisation.docker.enable = true;

    # 用户配置
    users.users.hengvvang.extraGroups = [ "docker" ];

    # 系统工具包
    environment.systemPackages = with pkgs; [
      docker
    ] ++ lib.optionals cfg.compose [
      docker-compose
    ] ++ lib.optionals cfg.monitoring [
      ctop
    ];

    # 网络配置
    networking.firewall.trustedInterfaces = [ "docker0" ];
  };
}
