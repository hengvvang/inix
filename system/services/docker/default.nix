{ config, lib, pkgs, ... }:

{
  # Docker 容器服务模块的选项定义
  options.mySystem.services.docker = {
    enable = lib.mkEnableOption "Docker 容器服务基础支持";
    
    # === 核心引擎选项 ===
    engine = {
      daemon = lib.mkEnableOption "Docker 守护进程" // { default = true; };
      rootless = lib.mkEnableOption "无根模式运行";
      storageDriver = lib.mkOption {
        type = lib.types.str;
        default = "overlay2";
        description = "存储驱动程序";
      };
      logDriver = lib.mkOption {
        type = lib.types.str;
        default = "json-file";
        description = "日志驱动程序";
      };
    };
    
    # === 编排工具选项 ===
    orchestration = {
      compose = lib.mkEnableOption "Docker Compose 编排工具";
      swarm = lib.mkEnableOption "Docker Swarm 集群模式";
      kubernetes = lib.mkEnableOption "Kubernetes 集成";
    };
    
    # === 构建工具选项 ===
    build = {
      buildkit = lib.mkEnableOption "BuildKit 构建器";
      cache = lib.mkEnableOption "构建缓存优化";
      multiPlatform = lib.mkEnableOption "多平台构建支持";
    };
    
    # === 网络选项 ===
    network = {
      bridge = lib.mkEnableOption "桥接网络" // { default = true; };
      host = lib.mkEnableOption "主机网络模式";
      overlay = lib.mkEnableOption "覆盖网络";
      ipv6 = lib.mkEnableOption "IPv6 支持";
    };
    
    # === 存储选项 ===
    storage = {
      volumes = lib.mkEnableOption "数据卷管理" // { default = true; };
      tmpfs = lib.mkEnableOption "临时文件系统支持";
      registry = lib.mkEnableOption "本地镜像仓库";
    };
    
    # === 监控和日志选项 ===
    observability = {
      monitoring = lib.mkEnableOption "容器监控 (Portainer/cAdvisor)";
      logging = lib.mkEnableOption "集中化日志管理";
      metrics = lib.mkEnableOption "指标收集";
    };
    
    # === 安全选项 ===
    security = {
      userNamespace = lib.mkEnableOption "用户命名空间隔离";
      seccomp = lib.mkEnableOption "系统调用过滤";
      apparmor = lib.mkEnableOption "AppArmor 安全模块";
      selinux = lib.mkEnableOption "SELinux 支持";
    };
  };

  imports = [
    # === 模块化导入：每个功能独立文件 ===
    ./engine.nix          # 核心引擎
    ./orchestration.nix   # 编排工具
    ./build.nix           # 构建工具
    ./network.nix         # 网络配置
    ./storage.nix         # 存储配置
    ./observability.nix   # 监控和日志
    ./security.nix        # 安全配置
  ];
}
