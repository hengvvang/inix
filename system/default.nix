{ config, lib, pkgs, ... }:

{
  # 系统模块入口 - 仅做导入，类似 home/default.nix
  imports = [
    ./desktop
    ./users
    ./packages
    ./localization
    ./services
  ];

  # 所有系统模块的默认配置 - 在主机配置中按需启用
  mySystem = {
    # 桌面环境模块
    desktop.cosmic.enable = lib.mkDefault false;
    
    # 用户配置模块
    users.enable = lib.mkDefault false;
    
    # 系统包模块
    packages.enable = lib.mkDefault false;
    
    # 本地化配置模块
    localization = {
      # 时区配置（只能选择一个）
      timeZone.shanghai.enable = lib.mkDefault false;
      timeZone.newYork.enable = lib.mkDefault false;
      timeZone.losAngeles.enable = lib.mkDefault false;
      
      # 输入法配置（只能选择一个）
      inputMethod.fcitx5.enable = lib.mkDefault false;
      inputMethod.ibus.enable = lib.mkDefault false;
    };
    
    # 服务配置模块 - 专注个人电脑使用场景
    services = {
      # Docker 容器服务
      docker = {
        enable = lib.mkDefault false;
        # 编排工具
        orchestration.compose = lib.mkDefault false;
        # 构建工具
        build.buildkit = lib.mkDefault false;
        # 存储服务
        storage.registry = lib.mkDefault false;
        # 监控服务
        observability.monitoring = lib.mkDefault false;
        # 安全功能
        security.userNamespace = lib.mkDefault false;
      };
      
      # 网络服务
      network = {
        enable = lib.mkDefault false;
        ssh = {
          enable = lib.mkDefault false;
          server.passwordAuth = lib.mkDefault false;
        };
      };
      
      # 多媒体服务
      media = {
        enable = lib.mkDefault false;
        players.enable = lib.mkDefault false;
        # 注释掉尚未实现的功能模块
        # editing.enable = lib.mkDefault false;
        # streaming.enable = lib.mkDefault false;
        # download.enable = lib.mkDefault false;
      };
      
      # === 硬件驱动服务（真正原子化，每个模块自定义选项） ===
      drivers.enable = lib.mkDefault false;
      # 注意：具体的驱动选项由各自模块定义，如：
      # drivers.nvidia.enable, drivers.nvidia.power.enable 等
      # drivers.audio.enable, drivers.audio.server.pipewire 等
    };
  };
}
