{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.packages = with pkgs; [
      swayidle
      brightnessctl    # 亮度控制（用于渐进式节能）
      libnotify        # 通知支持
    ];

    xdg.configFile."swayidle/config".source = ./config;
  };
}
