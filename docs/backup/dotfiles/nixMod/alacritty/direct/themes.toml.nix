{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable &&
                    config.myHome.dotfiles.alacritty.method == "direct") {

    home.file.".config/alacritty/themes/github_dark.toml" = {
      text = ''
        # GitHub Dark 主题配置
        [colors.primary]
        background = "#0d1117"
        foreground = "#c9d1d9"

        [colors.normal]
        black = "#484f58"
        red = "#ff7b72"
        green = "#7ee787"
        yellow = "#f0883e"
        blue = "#409eff"
        magenta = "#da77f2"
        cyan = "#76e3ea"
        white = "#b1bac4"

        [colors.bright]
        black = "#6e7681"
        red = "#ffa198"
        green = "#56d364"
        yellow = "#e3b341"
        blue = "#79c0ff"
        magenta = "#d2a8ff"
        cyan = "#b3f6ff"
        white = "#f0f6fc"
      '';
      target = ".config/alacritty/themes/github_dark.toml";
      force = true;
    };
  };
}
