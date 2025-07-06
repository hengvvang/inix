{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "external") {
    # 方式3: 外部文件引用
    home.file.".config/ghostty/config".source = ./configs/config;
    
    # 额外的主题和配置文件
    home.file.".config/ghostty/themes/.keep".text = "";
  };
}
