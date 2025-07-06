{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.docker.enable {
    # Docker 核心服务
    virtualisation.docker = {
      enable = true;
      storageDriver = "overlay2";
      daemon.settings = {
        log-driver = "json-file";
        log-opts = {
          max-size = "100m";
          max-file = "5";
        };
      };
    };

    # 用户组配置
    users.users.hengvvang.extraGroups = [ "docker" ];

    # 必要的内核模块和系统配置
    boot.kernelModules = [ "br_netfilter" "overlay" ];
    boot.kernel.sysctl = {
      "net.bridge.bridge-nf-call-iptables" = 1;
      "net.bridge.bridge-nf-call-ip6tables" = 1;
      "net.ipv4.ip_forward" = 1;
    };

    # 基础工具包
    environment.systemPackages = with pkgs; [
      docker
      docker-client
    ];
  };
}
