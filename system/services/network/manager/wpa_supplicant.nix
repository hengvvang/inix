{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.network.manager.enable &&
                    config.mySystem.services.network.manager.preset == "wpa_supplicant") {

    # 启用 wpa_supplicant
    networking.wireless = {
      enable = true;
      # 可以在这里配置特定的无线接口
      # interfaces = [ "wlan0" ];
    };

    # 禁用 NetworkManager（与 wpa_supplicant 冲突）
    networking.networkmanager.enable = false;

    # GUI 工具（如果启用）
    environment.systemPackages = lib.optionals
      (config.mySystem.services.network.manager.tools.gui) [
      pkgs.wpa_supplicant_gui  # wpa_supplicant 图形界面
    ];

    # 基础网络配置
    networking = {
      # 启用 DHCP（通常需要）
      useDHCP = lib.mkDefault true;

      # 可以在这里添加静态网络配置
      # interfaces = {
      #   eth0.useDHCP = true;
      #   wlan0.useDHCP = true;
      # };
    };
  };
}
