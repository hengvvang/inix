{ config, lib, pkgs, ... }:

{
  # WiFi 热点功能实现
  config = lib.mkIf (config.mySystem.services.drivers.wifi.enable && config.mySystem.services.drivers.wifi.hotspot.enable) {
    # 安装热点相关工具
    environment.systemPackages = with pkgs; [
      hostapd             # WiFi 热点服务
      dnsmasq             # DHCP 和 DNS 服务
      iptables            # 防火墙规则
    ];
    
    # hostapd 服务配置
    services.hostapd = {
      enable = true;
      radios."${config.mySystem.services.drivers.wifi.hotspot.interface}" = {
        band = "2g";
        countryCode = "CN";
        settings = {
          ssid = "NixOS-Hotspot";
          wpa = 2;
          wpa_passphrase = "changeme123";
          wpa_key_mgmt = "WPA-PSK";
          wpa_pairwise = "TKIP CCMP";
          rsn_pairwise = "CCMP";
        };
      };
    };
    
    # DHCP 服务配置
    services.dnsmasq = {
      enable = true;
      settings = {
        interface = config.mySystem.services.drivers.wifi.hotspot.interface;
        dhcp-range = "192.168.4.2,192.168.4.20,24h";
        dhcp-option = [
          "3,192.168.4.1"  # 网关
          "6,192.168.4.1"  # DNS
        ];
      };
    };
    
    # 网络配置
    networking.interfaces."${config.mySystem.services.drivers.wifi.hotspot.interface}" = {
      ipv4.addresses = [{
        address = "192.168.4.1";
        prefixLength = 24;
      }];
    };
    
    # IP 转发
    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
    };
    
    # NAT 规则
    networking.nat = {
      enable = true;
      externalInterface = "eth0";  # 可配置
      internalInterfaces = [ config.mySystem.services.drivers.wifi.hotspot.interface ];
    };
  };
}
