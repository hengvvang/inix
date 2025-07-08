{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.alacritty.enable && 
                    config.myHome.dotfiles.alacritty.method == "direct") {
    home.packages = with pkgs; [ alacritty ];
    
    # 直接写入简化配置 - 仅作为演示配置方式
    home.file.".config/alacritty/alacritty.toml".text = ''
      [env]
      TERM = "alacritty"

      [window]
      opacity = 0.95

      [font]
      size = 13

      [colors.primary]
      background = "#1a1b26"
      foreground = "#c0caf5"
    '';
  };
}
