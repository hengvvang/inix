{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable &&
                    config.myHome.dotfiles.alacritty.method == "direct") {

    home.file.".config/alacritty/alacritty.toml" = {
      text = ''
        # Alacritty 终端配置文件
        # 配置方式: direct - 直接文件配置

        # 导入主题
        import = ["~/.config/alacritty/themes/github_dark.toml"]

        # 终端环境变量
        [env]
        TERM = "xterm-256color"

        # 窗口设置
        [window]
        dimensions = { columns = 120, lines = 30 }
        padding = { x = 8, y = 8 }
        dynamic_padding = true
        decorations = "full"
        opacity = 0.95
        startup_mode = "Windowed"

        # 滚动设置
        [scrolling]
        history = 10000
        multiplier = 3

        # 字体配置
        [font]
        size = 16.0

        [font.normal]
        family = "JetBrains Mono"
        style = "Regular"

        [font.bold]
        family = "JetBrains Mono"
        style = "Bold"

        [font.italic]
        family = "JetBrains Mono"
        style = "Italic"

        # 颜色配置
        [colors.primary]
        background = "#0d1117"
        foreground = "#c9d1d9"

        # 光标配置
        [cursor]
        style = { shape = "Block", blinking = "On" }
        blink_interval = 750

        # 键盘绑定
        [[keyboard.bindings]]
        key = "V"
        mods = "Control|Shift"
        action = "Paste"

        [[keyboard.bindings]]
        key = "C"
        mods = "Control|Shift"
        action = "Copy"

        [[keyboard.bindings]]
        key = "N"
        mods = "Control|Shift"
        action = "SpawnNewInstance"
      '';
    };

    # 创建主题文件
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
    };
  };
}
