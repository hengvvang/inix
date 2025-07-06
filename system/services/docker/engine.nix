{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.docker.enable {
    # Docker 核心服务配置
    virtualisation.docker = {
      enable = true;
      storageDriver = "overlay2";
      
      # 守护进程配置
      daemon.settings = {
        log-driver = "journald";
        log-opts = {
          max-size = "100m";
          max-file = "5";
        };
        ip-forward = true;
        iptables = true;
      };
    };

    # 用户组配置 - 将用户添加到 docker 组
    users.users.hengvvang.extraGroups = [ "docker" ];

    # 必要的内核模块
    boot.kernelModules = [ "br_netfilter" "overlay" ];
    
    # 系统参数调优
    boot.kernel.sysctl = {
      "net.bridge.bridge-nf-call-iptables" = 1;
      "net.bridge.bridge-nf-call-ip6tables" = 1;
      "net.ipv4.ip_forward" = 1;
    };

    # 基础 Docker 工具
    environment.systemPackages = with pkgs; [
      docker
      docker-client
    ];
  };
}
