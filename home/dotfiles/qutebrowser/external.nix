{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "external") {
    # 外部文件引用 - 从 configs 目录引用配置文件
    home.file.".config/qutebrowser/config.py".source = ./configs/config.py;
    home.file.".config/qutebrowser/quickmarks".source = ./configs/quickmarks;
    
    # 如果有自定义样式文件
    # home.file.".config/qutebrowser/greasemonkey".source = ./configs/greasemonkey;
    
    # 安装相关工具包
    home.packages = with pkgs; [
      qutebrowser
      yt-dlp
      mpv
    ];
    
    # 注意：此方式需要手动维护 configs/ 目录下的配置文件
  };
}
