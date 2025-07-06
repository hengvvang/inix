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
      # 构建缓存脚本
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "docker-cache-prune" ''
          #!/bin/bash
          echo "清理 Docker 构建缓存..."
          docker builder prune -f
          echo "缓存清理完成"
        '')
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
