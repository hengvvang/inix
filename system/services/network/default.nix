{ config, lib, pkgs, ... }:

{
  # 网络服务模块的选项定义 
  options.mySystem.services.network = {
    enable = lib.mkEnableOption "网络服务基础支持";
  };

  imports = [
    # === 真正原子化：每个网络服务在自己的目录中定义所有选项 ===
    # 每个模块负责自己的选项定义和子功能实现
    
    ./basic.nix     # 基础网络配置模块 (hostname, networkmanager)
    ./ssh           # SSH 完整功能模块
    ./proxy         # 代理服务模块
  ];
}
