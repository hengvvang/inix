{ config, lib, pkgs, ... }:

{
  options.mySystem.services.development = {
    # 容器化开发环境
    docker = {
      enable = lib.mkEnableOption "Docker 容器服务";
      compose.enable = lib.mkEnableOption "Docker Compose 支持";
      buildkit.enable = lib.mkEnableOption "Docker Buildkit 构建器";
      registry.enable = lib.mkEnableOption "本地 Docker Registry";
      monitoring.enable = lib.mkEnableOption "Docker 监控和日志";
      security.enable = lib.mkEnableOption "Docker 安全增强配置";
    };
    
    # 虚拟化
    virtualization = {
      enable = lib.mkEnableOption "虚拟化支持 (QEMU/KVM)";
      virt-manager.enable = lib.mkEnableOption "Virt-Manager 图形界面";
      libvirt.enable = lib.mkEnableOption "Libvirt 虚拟化管理";
    };
    
    # 开发工具
    tools = {
      enable = lib.mkEnableOption "基础开发工具集";
      git.enhanced = lib.mkEnableOption "增强的 Git 配置";
      database.enable = lib.mkEnableOption "本地数据库工具 (SQLite, Redis 客户端等)";
    };
  };

  imports = [
    # Docker 相关
    ./core.nix
    ./compose.nix
    ./buildkit.nix
    ./registry.nix
    ./monitoring.nix
    ./security.nix
    
    # 新增功能
    ./virtualization.nix
    ./tools.nix
  ];
}
