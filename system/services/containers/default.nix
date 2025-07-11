{ config, lib, pkgs, ... }:

{
  # 容器服务配置选项
  options.mySystem.services.containers = {
    enable = lib.mkEnableOption "容器服务支持";
  };

  imports = [
    ./docker
    ./flatpak
  ];
}

