{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.containers.docker;
in
{
  # Docker 配置选项
  options.mySystem.services.containers.docker = {
    enable = lib.mkEnableOption "Docker 容器服务";
    
    compose = lib.mkEnableOption "Docker Compose 编排工具" // { default = true; };
    
    monitoring = lib.mkEnableOption "容器监控工具" // { default = false; };
    
    rootless = lib.mkEnableOption "Rootless Docker 模式" // { default = false; };
    
    nvidia = lib.mkEnableOption "NVIDIA GPU 容器支持" // { default = false; };
    
    registry = {
      enable = lib.mkEnableOption "本地 Docker Registry";
      port = lib.mkOption {
        type = lib.types.port;
        default = 5000;
        description = "Docker Registry 端口";
      };
    };
  };

  imports = [
    ./docker.nix
  ];
}
