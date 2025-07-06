{ config, lib, pkgs, ... }:

{
  # 以太网驱动模块的完整选项定义
  options.mySystem.services.drivers.ethernet = {
    enable = lib.mkEnableOption "以太网驱动基础支持";
    
    # === 网络配置选项 ===
    network = {
      dhcp = lib.mkEnableOption "DHCP 自动配置" // { default = true; };
      optimization = lib.mkEnableOption "网络性能优化" // { default = true; };
      jumboFrames = lib.mkEnableOption "巨型帧支持";
    };
    
    # === 工具选项 ===
    tools = {
      basic = lib.mkEnableOption "基础网络工具" // { default = true; };
      monitoring = lib.mkEnableOption "网络监控工具";
      testing = lib.mkEnableOption "网络测试工具";
    };
    
    # === 高级选项 ===
    advanced = {
      wakeonlan = lib.mkEnableOption "网络唤醒功能";
      bonding = lib.mkEnableOption "网卡绑定支持";
      vlan = lib.mkEnableOption "VLAN 支持";
    };
  };

  imports = [
    ./core.nix         # 核心以太网功能
    ./optimization.nix # 性能优化
    ./tools.nix        # 网络工具
    ./advanced.nix     # 高级功能
  ];
}
