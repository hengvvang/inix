{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "external") {
    # 安装相关工具包
    home.packages = lib.optionals config.myHome.dotfiles.qutebrowser.packageEnable (with pkgs; [
      qutebrowser
      yt-dlp
      mpv
    ]);

    home.file.".config/qutebrowser/config.py".source = ./configs/config.py;
    home.file.".config/qutebrowser/quickmarks".source = ./configs/quickmarks;

    # 如果有自定义样式文件
    # home.file.".config/qutebrowser/greasemonkey".source = ./configs/greasemonkey;

  };
}
