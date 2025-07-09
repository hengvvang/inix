{ config, lib, pkgs, ... }:

{
  options.mySystem.services.network.manager = {
    enable = lib.mkEnableOption "网络管理器配置支持";
    
    # 主机名配置
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      example = "my-laptop";
      description = "系统主机名";
    };
    
    preset = lib.mkOption {
      type = lib.types.enum [ "networkmanager" "wpa_supplicant" ];
      default = "networkmanager";
      description = ''
        网络管理器类型配置:
        - networkmanager: 现代图形化网络管理器，支持WiFi和有线网络的自动管理
        - wpa_supplicant: 传统命令行网络管理器，轻量级WiFi连接管理
      '';
    };
    
    # 网络工具
    tools = {
      enable = lib.mkEnableOption "网络诊断工具" // { default = true; };
      gui = lib.mkEnableOption "图形化网络管理工具" // { default = true; };
    };
  };

  config = lib.mkIf config.mySystem.services.network.manager.enable {
    # 设置主机名
    networking.hostName = config.mySystem.services.network.manager.hostname;
    
    # 基础网络工具
    environment.systemPackages = lib.optionals config.mySystem.services.network.manager.tools.enable [
      pkgs.wget
      pkgs.curl
      pkgs.dig
      pkgs.nmap
      pkgs.traceroute
      pkgs.whois
      pkgs.nettools
      pkgs.iproute2
    ];
  };

  imports = [
    ./networkmanager.nix
    ./wpa_supplicant.nix
  ];
}
