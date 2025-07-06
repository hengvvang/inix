{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.docker.enable {
    # Docker 核心服务配置
    virtualisation.docker = {
      enable = true;
      storageDriver = config.mySystem.services.docker.storageDriver;
      rootless = {
        enable = false; # 系统级 Docker，非 rootless
        setSocketVariable = true;
      };
      
      # 守护进程配置
      daemon.settings = {
        data-root = config.mySystem.services.docker.dataRoot;
        log-driver = config.mySystem.services.docker.logDriver;
        log-opts = {
          max-size = "100m";
          max-file = "5";
        };
        
        # 性能优化
        storage-opts = lib.optionals (config.mySystem.services.docker.storageDriver == "overlay2") [
          "overlay2.override_kernel_check=true"
        ];
        
        # 网络配置
        ip-forward = true;
        iptables = true;
        
        # 资源限制
        default-ulimits = {
          nofile = {
            name = "nofile";
            hard = 64000;
            soft = 64000;
          };
        };
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

    # 自动启动和重启策略
    systemd.services.docker = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = "5s";
        TimeoutStartSec = "0";
        TimeoutStopSec = "30s";
      };
    };
  };
}
