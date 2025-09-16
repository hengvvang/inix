{ config, lib, pkgs, ... }:

{
  imports = [
    ./networkmanager.nix
    ./wpa_supplicant.nix
  ];

  options.mySystem.services.network.manager = {
    enable = lib.mkEnableOption "网络管理器配置支持";

    preset = lib.mkOption {
      type = lib.types.enum [ "networkmanager" "wpa_supplicant" ];
      default = "networkmanager";
      description = ''
        网络管理器类型配置:
        - networkmanager: 现代图形化网络管理器,支持WiFi和有线网络的自动管理
        - wpa_supplicant: 传统命令行网络管理器,轻量级WiFi连接管理
      '';
    };

    # 网络工具
    tools = {
      enable = lib.mkEnableOption "网络诊断工具" // { default = true; };
      cli = lib.mkEnableOption "命令行网络工具" // { default = true; };
      gui = lib.mkEnableOption "图形化网络管理工具" // { default = true; };
    };
  };

  config = lib.mkIf config.mySystem.services.network.manager.enable {

    # 基础网络工具
    environment.systemPackages = lib.optionals (config.mySystem.services.network.manager.tools.enable && config.mySystem.services.network.manager.tools.cli) [
      pkgs.wget
      pkgs.curl
      pkgs.dig
      pkgs.nmap
      pkgs.traceroute
      pkgs.whois
      pkgs.nettools
      pkgs.iproute2
    ]
    # 图形化网络工具 - 通用
    ++ lib.optionals (config.mySystem.services.network.manager.tools.enable && config.mySystem.services.network.manager.tools.gui) [
      pkgs.wireshark
      pkgs.zenmap
    ]
    # NetworkManager 专用图形界面
    ++ lib.optionals (config.mySystem.services.network.manager.tools.enable &&
                      config.mySystem.services.network.manager.tools.gui &&
                      config.mySystem.services.network.manager.preset == "networkmanager") [
      pkgs.networkmanagerapplet
    ]
    # wpa_supplicant 专用图形界面
    ++ lib.optionals (config.mySystem.services.network.manager.tools.enable &&
                      config.mySystem.services.network.manager.tools.gui &&
                      config.mySystem.services.network.manager.preset == "wpa_supplicant") [
      pkgs.wpa_supplicant_gui
    ];
  };
}
