{ config, lib, pkgs, ... }:

{
  imports = [
    ./docker.nix
  ];

  options.mySystem.services.containers.docker = {
    enable = lib.mkEnableOption "Docker 容器服务";

    rootless = lib.mkEnableOption "Rootless Docker 模式" // { default = false; };

    btrfs = lib.mkEnableOption "Btrfs 存储驱动支持" // { default = false; };

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
}
