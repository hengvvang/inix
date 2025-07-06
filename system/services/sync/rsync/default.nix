{ config, lib, pkgs, ... }:

{
  # Rsync 同步模块的完整选项定义
  options.mySystem.services.sync.rsync = {
    enable = lib.mkEnableOption "Rsync 同步基础支持";
    
    # === 客户端选项 ===
    client = {
      enable = lib.mkEnableOption "Rsync 客户端" // { default = true; };
      gui = lib.mkEnableOption "图形界面客户端";
      scripting = lib.mkEnableOption "脚本化工具";
    };
    
    # === 服务器选项 ===
    server = {
      enable = lib.mkEnableOption "Rsync 服务器";
      daemon = lib.mkEnableOption "Rsync 守护进程";
      ssh = lib.mkEnableOption "SSH 传输支持" // { default = true; };
    };
    
    # === 同步模式选项 ===
    modes = {
      local = lib.mkEnableOption "本地同步";
      remote = lib.mkEnableOption "远程同步";
      incremental = lib.mkEnableOption "增量同步" // { default = true; };
      bidirectional = lib.mkEnableOption "双向同步";
    };
    
    # === 高级选项 ===
    advanced = {
      compression = lib.mkEnableOption "传输压缩" // { default = true; };
      encryption = lib.mkEnableOption "传输加密";
      bandwidth = lib.mkEnableOption "带宽限制";
      monitoring = lib.mkEnableOption "同步监控";
    };
  };

  imports = [
    ./client.nix       # 客户端功能
    ./server.nix       # 服务器功能
    ./sync.nix         # 同步功能
    ./advanced.nix     # 高级功能
  ];
}
