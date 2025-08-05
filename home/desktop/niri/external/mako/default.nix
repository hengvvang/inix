{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.packages = with pkgs; [
      mako
      lxgw-wenkai         # 霞鹜文楷
    ];

    # Mako 通知守护进程配置
    services.mako = {
      enable = true;
      package = pkgs.mako;
    };

    # 使用外部配置文件
    # 主题选择（可选配置）：
    # - ./config (macOS Tahoe 深色主题，默认)
    # - ./config-light (macOS Tahoe 浅色主题)

    # 当前使用：深色主题
    xdg.configFile."mako/config".source = ./config;

    # 可选：直接使用浅色主题
    # xdg.configFile."mako/config".source = ./config-light;


    # home.file.".local/bin/script-template" = {
    #   source = ./<path_to_script>/<script_name>.sh;
    #   executable = true;
    # };

    # home.file.".local/bin/script-template" = {
    #   text = ''
    #   '';
    #   executable = true;
    # };

  };
}
