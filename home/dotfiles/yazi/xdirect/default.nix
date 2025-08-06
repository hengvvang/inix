{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "xdirect") {

    home.packages = with pkgs; [ yazi ];

    # 配置文件
    home.file.".config/yazi/yazi.toml".text = builtins.readFile ./configs/yazi.toml;
    home.file.".config/yazi/keymap.toml".text = builtins.readFile ./configs/keymap.toml;
    home.file.".config/yazi/theme.toml".text = builtins.readFile ./configs/theme.toml;
    home.file.".config/yazi/init.lua".text = builtins.readFile ./configs/init.lua;

    # 插件和flavors目录
    home.file.".config/yazi/flavors".source = ./configs/flavors;
    home.file.".config/yazi/plugins".source = ./configs/plugins;
  };
}
