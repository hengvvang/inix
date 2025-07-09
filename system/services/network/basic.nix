{ config, lib, pkgs, ... }:

{
  # 基础网络配置模块
  options.mySystem.services.network.basic = {
    enable = lib.mkEnableOption "基础网络配置支持";
    
    # 主机名配置
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      example = "my-laptop";
      description = "系统主机名";
    };
    
    # 网络管理器配置
    networkManager = {
      enable = lib.mkEnableOption "NetworkManager 网络管理器" // { default = true; };
      wifi = {
        enable = lib.mkEnableOption "WiFi 支持" // { default = true; };
        powersave = lib.mkEnableOption "WiFi 节能模式" // { default = true; };
      };
      ethernet = {
        enable = lib.mkEnableOption "以太网支持" // { default = true; };
      };
    };
    
    # 无线网络配置（替代方案）
    wireless = {
      enable = lib.mkEnableOption "wpa_supplicant 无线网络管理";
      interfaces = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        example = [ "wlan0" ];
        description = "无线网络接口列表";
      };
    };
    
    # 网络工具
    tools = {
      enable = lib.mkEnableOption "网络诊断工具" // { default = true; };
      gui = lib.mkEnableOption "图形化网络管理工具" // { default = true; };
    };
  };

  config = lib.mkMerge [
    # 基础网络配置
    (lib.mkIf config.mySystem.services.network.basic.enable {
      # 设置主机名
      networking.hostName = config.mySystem.services.network.basic.hostname;
      
      # 基础网络工具
      environment.systemPackages = lib.optionals config.mySystem.services.network.basic.tools.enable [
        pkgs.wget
        pkgs.curl
        pkgs.dig
        pkgs.nmap
        pkgs.traceroute
        pkgs.whois
        pkgs.nettools
        pkgs.iproute2
      ] ++ lib.optionals (config.mySystem.services.network.basic.tools.gui && config.mySystem.services.network.basic.networkManager.enable) [
        pkgs.networkmanagerapplet
      ];
    })

    # NetworkManager 配置
    (lib.mkIf (config.mySystem.services.network.basic.enable && config.mySystem.services.network.basic.networkManager.enable) {
      networking.networkmanager = {
        enable = true;
        wifi = {
          powersave = config.mySystem.services.network.basic.networkManager.wifi.powersave;
        };
      };
      
      # 禁用 wpa_supplicant（与 NetworkManager 冲突）
      networking.wireless.enable = false;
      
    })

    # wpa_supplicant 配置（NetworkManager 的替代方案）
    (lib.mkIf (config.mySystem.services.network.basic.enable && config.mySystem.services.network.basic.wireless.enable) {
      networking.wireless = {
        enable = true;
        interfaces = config.mySystem.services.network.basic.wireless.interfaces;
      };
      
      # 禁用 NetworkManager（与 wpa_supplicant 冲突）
      networking.networkmanager.enable = false;
      
      # 基础网络工具
      environment.systemPackages = [
        pkgs.wpa_supplicant_gui  # GUI 工具
      ];
    })

    # 冲突检查
    {
      assertions = [
        {
          assertion = !(config.mySystem.services.network.basic.networkManager.enable && config.mySystem.services.network.basic.wireless.enable);
          message = "NetworkManager 和 wpa_supplicant 不能同时启用，请选择其中一个";
        }
      ];
    }
  ];
}
