{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.network.manager.enable &&
                    config.mySystem.services.network.manager.preset == "networkmanager") {

    # 启用 NetworkManager
    networking.networkmanager = {
      enable = true;
      wifi = {
        powersave = true;  # 启用WiFi节能模式
      };
    };

    # 禁用 wpa_supplicant（与 NetworkManager 冲突）
    networking.wireless.enable = false;

    # 系统服务
    systemd.services.NetworkManager-wait-online.enable = false;  # 加速启动
  };
}
