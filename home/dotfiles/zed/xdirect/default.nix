{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.method == "xdirect") {

    home.packages = lib.optionals config.myHome.dotfiles.zed.packageEnable (with pkgs; [ zed-editor ]);

    # 配置文件
    home.file.".config/zed/settings.json" = {
      text = builtins.readFile ./configs/settings.json;
      force = false;
    };

    home.file.".config/zed/keymap.json" = {
      text = builtins.readFile ./configs/keymap.json;
      force = false;
    };

    # 主题目录
    home.file.".config/zed/themes".source = ./configs/themes;
  };
}
