{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.alacritty.enable && 
                    config.myHome.dotfiles.alacritty.method == "external") {
    home.packages = with pkgs; [ alacritty ];
    
    # 外部配置文件引用 - 仅作为演示配置方式
    # 注意：此方式需要手动维护 configs/alacritty.toml 文件
    home.file.".config/alacritty/alacritty.toml" = {
      source = ./configs/alacritty.toml;
      executable = false;
    };
  };
}
