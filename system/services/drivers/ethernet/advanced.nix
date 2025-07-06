{ config, lib, pkgs, ... }:

{
  # 以太网高级功能实现
  config = lib.mkMerge [
    # 网络唤醒功能
    (lib.mkIf (config.mySystem.services.drivers.ethernet.enable && config.mySystem.services.drivers.ethernet.advanced.wakeonlan) {
      environment.systemPackages = with pkgs; [
        ethtool           # WOL 配置
        wakeonlan         # WOL 发送工具
      ];
    })
    
    # 网卡绑定支持（企业功能，保留但简化）
    (lib.mkIf (config.mySystem.services.drivers.ethernet.enable && config.mySystem.services.drivers.ethernet.advanced.bonding) {
      boot.kernelModules = [ "bonding" ];
      environment.systemPackages = with pkgs; [
        ifenslave         # 绑定工具
      ];
    })
    
    # VLAN 支持（企业功能，保留但简化）
    (lib.mkIf (config.mySystem.services.drivers.ethernet.enable && config.mySystem.services.drivers.ethernet.advanced.vlan) {
      boot.kernelModules = [ "8021q" ];
      environment.systemPackages = with pkgs; [
        vlan              # VLAN 工具
      ];
    })
  ];
}
