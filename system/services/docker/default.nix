{ config, lib, pkgs, ... }:

{
  # Docker 容器服务配置选项
  options.mySystem.services.docker = {
    enable = lib.mkEnableOption "Docker 容器服务支持";
    
    # 基础配置
    compose = lib.mkEnableOption "Docker Compose 编排工具" // { default = true; };
    monitoring = lib.mkEnableOption "容器监控工具" // { default = false; };
  };

  imports = [
    ./docker.nix
  ];
}

