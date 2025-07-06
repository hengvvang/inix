{ config, lib, pkgs, ... }:

{
  # 以太网核心功能实现
  config = lib.mkIf config.mySystem.services.drivers.ethernet.enable {
    # 网络基础配置
    networking.useDHCP = config.mySystem.services.drivers.ethernet.network.dhcp;
    
    # 基础以太网工具
    environment.systemPackages = with pkgs; [
      ethtool           # 以太网工具
      mii-tool          # 媒体独立接口工具
    ];
    
    # 内核模块
    boot.kernelModules = [ "8021q" ];  # VLAN 支持
    
    # 网络接口自动检测和配置
    systemd.network.enable = true;
    
    # 设备权限
    services.udev.extraRules = ''
      # 以太网设备权限
      SUBSYSTEM=="net", ATTR{type}=="1", GROUP="wheel", MODE="0664"
    '';
    
    # 巨型帧支持
    boot.kernel.sysctl = lib.mkIf config.mySystem.services.drivers.ethernet.network.jumboFrames {
      "net.core.rmem_max" = 134217728;
      "net.core.wmem_max" = 134217728;
    };
  };
}
