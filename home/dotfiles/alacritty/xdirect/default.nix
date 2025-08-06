{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable &&
                    config.myHome.dotfiles.alacritty.method == "xdirect") {
    home.packages = with pkgs; [ alacritty ];

    home.file.".config/alacritty/alacritty.toml" = {
      text = builtins.readFile ./configs/alacritty.toml;
      force = false;  # 不强制覆盖已存在的文件
    };
  };
}
