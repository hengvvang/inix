{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && 
                     config.myHome.dotfiles.obs-studio.method == "external") {
    
    # 外部配置文件方式 - 演示用
    home.file.".config/obs-studio/global.ini".source = ./configs/global.ini;
  };
}
