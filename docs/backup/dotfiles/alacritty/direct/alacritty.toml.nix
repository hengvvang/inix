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
      target = ".config/alacritty/alacritty.toml";
      force = true;
    };
  };
}
