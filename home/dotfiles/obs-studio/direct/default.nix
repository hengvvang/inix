{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && config.myHome.dotfiles.obs-studio.method == "direct") {
    home.packages = with pkgs; [
      obs-studio
    ];

    # OBS Studio的配置通常在~/.config/obs-studio/目录下
    # 这里展示如何直接配置一些基本设置
    home.file.".config/obs-studio/global.ini".text = ''
      [General]
      FirstRun=false
    '';
  };
}
