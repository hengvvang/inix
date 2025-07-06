{ config, lib, pkgs, ... }:

{
  # Docker 构建工具实现
  config = lib.mkMerge [
    # BuildKit 构建器
    (lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.build.buildkit) {
      virtualisation.docker.daemon.settings = {
        features = {
          buildkit = true;
        };
      };
      
      environment.systemPackages = with pkgs; [
        buildkit
      ];
    })
    
    # 构建缓存优化
    (lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.build.cache) {
      # 构建缓存管理 (Docker CLI 已包含 builder prune 功能)
      environment.systemPackages = with pkgs; [
        docker
      ];
    })
    
    # 多平台构建支持
    (lib.mkIf (config.mySystem.services.docker.enable && config.mySystem.services.docker.build.multiPlatform) {
      boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];
      
      environment.systemPackages = with pkgs; [
        qemu
      ];
    })
  ];
}
