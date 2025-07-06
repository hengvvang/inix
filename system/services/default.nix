{ config, lib, pkgs, ... }:

{
    options.mySystem.services = {
        docker.enable = lib.mkEnableOption "Docker 服务配置";
        ssh.enable = lib.mkEnableOption "SSH 服务配置";
    };
}
