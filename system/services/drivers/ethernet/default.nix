{ config, lib, pkgs, ... }:

{
  # 以太网驱动模块 - 合理分层版
  options.mySystem.services.drivers.ethernet = {
    enable = lib.mkEnableOption "以太网驱动支持";
    
    # 基础网络配置
    dhcp = lib.mkEnableOption "DHCP 自动配置" // { default = true; };
    optimization = lib.mkEnableOption "网络性能优化" // { default = false; };
    
    # 工具配置
    tools = {
      basic = lib.mkEnableOption "基础网络工具" // { default = true; };
      monitoring = lib.mkEnableOption "网络监控工具" // { default = false; };
    };
    
    # 高级功能（企业级功能，单独模块）
    advanced = {
      enable = lib.mkEnableOption "高级以太网功能";
      wakeonlan = lib.mkEnableOption "网络唤醒功能" // { default = false; };
      bonding = lib.mkEnableOption "网卡绑定支持" // { default = false; };
      vlan = lib.mkEnableOption "VLAN 支持" // { default = false; };
    };
  };

  imports = [
    ./advanced.nix    # 高级功能：WOL、绑定、VLAN
    ./ethernet.nix
  ];

}
