{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "direct") {
    
    home.file.".config/rio/config.toml" = {
      text = ''
        # Rio 终端配置文件
        # 配置方式: direct - 直接文件配置

        # 光标设置
        cursor = '_'
        blinking-cursor = true

        # 性能设置
        performance = "High"
        hide-cursor-when-typing = false

        # 窗口设置
        [window]
        width = 1200
        height = 800
        mode = "Windowed"
        opacity = 0.95
        blur = false
        decorations = "Enabled"

        # 字体设置
        [fonts]
        family = "JetBrains Mono"
        size = 16

        [fonts.extras]
        family = "JetBrains Mono"

        # 滚动设置
        [scroll]
        multiplier = 3.0
        divider = 1.0

        # 导航设置
        [navigation]
        mode = "CollapsedTab"
        clickable = false
        use-current-path = false
        color-automation = []

        # 键绑定
        [bindings]
        keys = [
          { key = "q", with = "super", action = "Quit" },
          { key = "w", with = "super", action = "CloseTab" },
          { key = "t", with = "super", action = "CreateTab" },
          { key = "return", with = "super", action = "ToggleFullscreen" },
          { key = "c", with = "super", action = "Copy" },
          { key = "v", with = "super", action = "Paste" },
          { key = "f", with = "super", action = "Search" },
          { key = "1", with = "super", action = "SelectTab1" },
          { key = "2", with = "super", action = "SelectTab2" },
          { key = "3", with = "super", action = "SelectTab3" },
          { key = "4", with = "super", action = "SelectTab4" },
          { key = "5", with = "super", action = "SelectTab5" },
          { key = "6", with = "super", action = "SelectTab6" },
          { key = "7", with = "super", action = "SelectTab7" },
          { key = "8", with = "super", action = "SelectTab8" },
          { key = "9", with = "super", action = "SelectTab9" },
          { key = "0", with = "super", action = "SelectLastTab" }
        ]

        # 颜色主题 - GitHub Dark
        [colors]
        background = "#0d1117"
        foreground = "#c9d1d9"
        cursor = "#c9d1d9"
        tabs = "#21262d"
        tabs-active = "#58a6ff"
        green = "#7ee787"
        red = "#ff7b72"
        blue = "#58a6ff"
        yellow = "#f0883e"
        orange = "#ffa657"
        magenta = "#da77f2"
        cyan = "#76e3ea"
        white = "#b1bac4"
        black = "#21262d"
        selection-foreground = "#c9d1d9"
        selection-background = "#264f78"
        light-black = "#484f58"
        light-red = "#ffa198"
        light-green = "#56d364"
        light-yellow = "#e3b341"
        light-blue = "#79c0ff"
        light-magenta = "#d2a8ff"
        light-cyan = "#b3f6ff"
        light-white = "#f0f6fc"
        dim-black = "#484f58"
        dim-red = "#ff7b72"
        dim-green = "#7ee787"
        dim-yellow = "#f0883e"
        dim-blue = "#58a6ff"
        dim-magenta = "#da77f2"
        dim-cyan = "#76e3ea"
        dim-white = "#8b949e"

        # 开发者选项
        [developer]
        log-level = "OFF"
        enable-fps-counter = false
        disable-render-when-unfocused = false

        # Shell 集成
        [shell]
        program = "${pkgs.fish}/bin/fish"
        args = ["--login"]

        # 环境变量
        [env-vars]
        TERM = "xterm-256color"
        COLORTERM = "truecolor"
      '';
    };
  };
}
