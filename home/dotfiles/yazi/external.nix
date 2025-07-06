{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "external") {
    # 方式3: 外部文件引用
    home.file.".config/yazi/yazi.toml".source = ./configs/yazi.toml;
    home.file.".config/yazi/keymap.toml".source = ./configs/keymap.toml;
    home.file.".config/yazi/theme.toml".source = ./configs/theme.toml;
    
    # 额外的插件和扩展目录
    home.file.".config/yazi/plugins/.keep".text = "";
    home.file.".config/yazi/flavors/.keep".text = "";
  };
}
