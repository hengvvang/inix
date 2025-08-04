{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.packages = with pkgs; [
      rofi
    ];

    home.file = {

      # Rofi 配置文件
      ".config/rofi/config.rasi" = {
        source = ./config.rasi;
      };

      # Rofi 主题文件
      ".config/rofi/themes/default.rasi" = {
        source = ./themes/default.rasi;
      };

      # 可选：Rofi 主题切换脚本
      ".local/bin/rofi-theme-switcher" = {
        source = ./theme-switcher.sh;
        executable = true;  # 确保脚本可执行
      };
    };
  };
}
