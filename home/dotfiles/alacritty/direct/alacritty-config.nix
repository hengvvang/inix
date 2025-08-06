{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable && 
                    config.myHome.dotfiles.alacritty.method == "direct") {
    home.file.".config/alacritty/alacritty.toml" = {
      text = ''
        # Alacritty 直接配置 - Direct Method
        # 这是使用 direct 方式的 Alacritty 配置示例

        # === 窗口配置 ===
        [window]
        # 窗口尺寸 (列 x 行)
        dimensions = { columns = 120, lines = 30 }
        
        # 窗口内边距
        padding = { x = 8, y = 8 }
        
        # 动态内边距
        dynamic_padding = true
        
        # 窗口装饰
        decorations = "none"
        
        # 启动模式
        startup_mode = "Windowed"
        
        # 窗口透明度 (0.0 - 1.0)
        opacity = 0.95

        # === 字体配置 ===
        [font]
        # 普通字体
        normal = { family = "JetBrains Mono", style = "Regular" }
        
        # 粗体字体
        bold = { family = "JetBrains Mono", style = "Bold" }
        
        # 斜体字体
        italic = { family = "JetBrains Mono", style = "Italic" }
        
        # 粗斜体字体
        bold_italic = { family = "JetBrains Mono", style = "Bold Italic" }
        
        # 字体大小
        size = 12.0
        
        # 字体偏移
        offset = { x = 0, y = 0 }

        # === 颜色配置 ===
        [colors.primary]
        background = "#1e1e2e"  # Catppuccin Mocha 背景色
        foreground = "#cdd6f4"  # Catppuccin Mocha 前景色
        dim_foreground = "#7f849c"
        bright_foreground = "#cdd6f4"

        [colors.cursor]
        text = "#1e1e2e"
        cursor = "#f5e0dc"

        [colors.vi_mode_cursor]
        text = "#1e1e2e"
        cursor = "#b4befe"

        [colors.search.matches]
        foreground = "#1e1e2e"
        background = "#a6adc8"

        [colors.search.focused_match]
        foreground = "#1e1e2e"
        background = "#a6e3a1"

        [colors.footer_bar]
        foreground = "#1e1e2e"
        background = "#a6adc8"

        [colors.hints.start]
        foreground = "#1e1e2e"
        background = "#f9e2af"

        [colors.hints.end]
        foreground = "#1e1e2e"
        background = "#a6adc8"

        [colors.selection]
        text = "#1e1e2e"
        background = "#f5e0dc"

        [colors.normal]
        black = "#45475a"
        red = "#f38ba8"
        green = "#a6e3a1"
        yellow = "#f9e2af"
        blue = "#89b4fa"
        magenta = "#f5c2e7"
        cyan = "#94e2d5"
        white = "#bac2de"

        [colors.bright]
        black = "#585b70"
        red = "#f38ba8"
        green = "#a6e3a1"
        yellow = "#f9e2af"
        blue = "#89b4fa"
        magenta = "#f5c2e7"
        cyan = "#94e2d5"
        white = "#a6adc8"

        [colors.dim]
        black = "#45475a"
        red = "#f38ba8"
        green = "#a6e3a1"
        yellow = "#f9e2af"
        blue = "#89b4fa"
        magenta = "#f5c2e7"
        cyan = "#94e2d5"
        white = "#bac2de"

        # === 滚动配置 ===
        [scrolling]
        # 历史记录行数
        history = 10000
        
        # 滚动倍数
        multiplier = 3

        # === 光标配置 ===
        [cursor]
        # 光标样式: Block, Underline, Beam
        style = "Block"
        
        # 失焦时显示空心光标
        unfocused_hollow = true
        
        # 光标闪烁间隔 (毫秒)
        blink_interval = 750
        
        # 光标闪烁超时 (秒)
        blink_timeout = 5

        # === 终端配置 ===
        [terminal]
        # 终端类型
        shell = { program = "fish" }

        # === 鼠标配置 ===
        [mouse]
        # 隐藏鼠标延迟 (秒)
        hide_when_typing = true

        # === 键绑定配置 ===
        [[keyboard.bindings]]
        key = "V"
        mods = "Control|Shift"
        action = "Paste"

        [[keyboard.bindings]]
        key = "C"
        mods = "Control|Shift"
        action = "Copy"

        [[keyboard.bindings]]
        key = "Insert"
        mods = "Shift"
        action = "PasteSelection"

        [[keyboard.bindings]]
        key = "Key0"
        mods = "Control"
        action = "ResetFontSize"

        [[keyboard.bindings]]
        key = "Equals"
        mods = "Control"
        action = "IncreaseFontSize"

        [[keyboard.bindings]]
        key = "Minus"
        mods = "Control"
        action = "DecreaseFontSize"

        # === 环境变量 ===
        [env]
        TERM = "alacritty"
      '';
    };
  };
}
