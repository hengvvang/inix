{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.packages = with pkgs; [
      mako
    ];

    # Mako 通知守护进程配置
    services.mako = {
      enable = true;
      package = pkgs.mako;
    };

    fonts.packages = with pkgs; [ lxgw-wenkai ];

    # 使用外部配置文件
    # 主题选择（可选配置）：
    # - ./config (macOS Tahoe 深色主题，默认)
    # - ./config-light (macOS Tahoe 浅色主题)

    # 当前使用：深色主题
    xdg.configFile."mako/config".source = ./config;

    # 可选：直接使用浅色主题
    # xdg.configFile."mako/config".source = ./config-light;

    # 确保安装必需的字体和图标
    # 注意：这些通常在系统级别配置，这里添加注释提醒
    # fonts.packages = with pkgs; [ lxgw-wenkai ];
    # environment.systemPackages = with pkgs; [ papirus-icon-theme ];

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
