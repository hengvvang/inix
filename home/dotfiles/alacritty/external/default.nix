{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable &&
                    config.myHome.dotfiles.alacritty.method == "external") {
    home.packages = with pkgs; [ alacritty ];

    home.file.".config/alacritty/alacritty.toml" = {
      source = ./configs/alacritty.toml;
      # 设置为只读，确保配置文件不被意外修改
      # readonly = true;  # 可选，如果希望可以手动修改配置则注释此行
    };
    home.file.".config/alacritty/themes" = {
      source = ./configs/themes;
    };
  };
}
