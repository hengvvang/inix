{ config, lib, pkgs, ... }:

{
  # 同步和备份服务模块的选项定义
  options.mySystem.services.sync = {
    enable = lib.mkEnableOption "同步和备份服务基础支持";
  };

  imports = [
    # === 真正原子化：每个同步服务在自己的目录中定义所有选项 ===
    # 每个模块负责自己的选项定义和子功能实现
    
    ./syncthing      # Syncthing 完整功能模块
    ./cloud          # 云存储同步完整功能模块
    ./backup         # 备份工具完整功能模块
    ./rsync          # Rsync 同步完整功能模块
  ];
}
