{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.method == "external") {

    home.packages = with pkgs; [
      zed-editor
    ];

    home.file.".config/zed/settings.json" = {
      source = ./configs/settings.json;
      # 设置为只读，确保配置文件不被 Zed 修改
      # readonly = true;  # 可选，如果希望 Zed 可以修改配置则注释此行
    };
    home.file.".config/zed/keymap.json" = {
      source = ./configs/keymap.json;
      # readonly = true;  # 可选
    };
    home.file.".config/zed/themes" = {
      source = ./configs/themes;
      recursive = true;  # 递归复制整个目录
    };
  };
}
