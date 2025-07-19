{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "homemanager") {
    # Rio - 现代化GPU加速终端配置
    home.packages = with pkgs; [ 
      # Rio 终端本体
      rio
      
      # 字体支持
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Hack" ]; })
      
      # 剪贴板工具
      wl-clipboard  # Wayland
      xclip         # X11
      
      # 颜色工具
      grc           # 通用着色器
      lolcat        # 彩虹文本
      
      # 终端工具
      tree          # 目录树显示
      htop          # 系统监控
      neofetch      # 系统信息
    ];
    
    # Rio 配置文件
    home.file.".config/rio/config.toml".text = ''
      # Rio Terminal 现代化配置
      # GPU加速的高性能终端
      
      # 渲染设置
      [renderer]
      # 使用 GPU 加速渲染 (WebGPU)
      backend = "automatic"
      # 禁用 vsync 以获得更好的性能
      disable-renderer-when-unfocused = true
      
      # 窗口设置
      [window]
      # 窗口尺寸 (字符数)
      width = 120
      height = 40
      
      # 窗口模式设置
      mode = "Windowed"  # 可选: "Windowed", "Maximized", "Fullscreen"
      
      # 窗口装饰
      decorations = "Enabled"  # 可选: "Enabled", "Disabled", "Transparent"
      
      # 背景透明度 (0.0 - 1.0)
      opacity = 0.95
      
      # 背景模糊
      blur = false
      
      # 字体设置
      [fonts]
      # 主字体族
      family = "FiraCode Nerd Font"
      
      # 字体大小
      size = 14
      
      # 字体特性
      [fonts.extras]
      # 启用连字符 (ligatures)
      ligatures = true
      
      # 字体权重设置
      [fonts.regular]
      family = "FiraCode Nerd Font"
      style = "Regular"
      
      [fonts.bold]
      family = "FiraCode Nerd Font"
      style = "Bold"
      
      [fonts.italic]
      family = "FiraCode Nerd Font"
      style = "Italic"
      
      [fonts.bold-italic]
      family = "FiraCode Nerd Font"
      style = "Bold Italic"
      
      # Shell 设置
      [shell]
      # 默认使用 Fish shell
      program = "${pkgs.fish}/bin/fish"
      
      # Shell 参数
      args = []
      
      # 环境变量
      [env]
      TERM = "xterm-256color"
      COLORTERM = "truecolor"
      
      # 主题设置 - Catppuccin Mocha
      [colors]
      # 基础颜色
      background = "#1e1e2e"
      foreground = "#cdd6f4"
      
      # 光标颜色
      cursor = "#f5e0dc"
      
      # 选择区域颜色
      selection-foreground = "#1e1e2e"
      selection-background = "#f5e0dc"
      
      # 标准颜色 (0-7)
      [colors.normal]
      black = "#45475a"
      red = "#f38ba8"
      green = "#a6e3a1"
      yellow = "#f9e2af"
      blue = "#89b4fa"
      magenta = "#f5c2e7"
      cyan = "#94e2d5"
      white = "#bac2de"
      
      # 高亮颜色 (8-15)
      [colors.bright]
      black = "#585b70"
      red = "#f38ba8"
      green = "#a6e3a1"
      yellow = "#f9e2af"
      blue = "#89b4fa"
      magenta = "#f5c2e7"
      cyan = "#94e2d5"
      white = "#a6adc8"
      
      # 暗色调颜色
      [colors.dim]
      black = "#1e1e2e"
      red = "#f38ba8"
      green = "#a6e3a1"
      yellow = "#f9e2af"
      blue = "#89b4fa"
      magenta = "#f5c2e7"
      cyan = "#94e2d5"
      white = "#cdd6f4"
      
      # 键绑定设置
      [bindings]
      keys = [
        # 标准复制粘贴
        { key = "c", mods = "control|shift", action = "Copy" },
        { key = "v", mods = "control|shift", action = "Paste" },
        
        # 字体大小调整
        { key = "plus", mods = "control", action = "IncreaseFontSize" },
        { key = "minus", mods = "control", action = "DecreaseFontSize" },
        { key = "0", mods = "control", action = "ResetFontSize" },
        
        # 全屏切换
        { key = "f11", action = "ToggleFullscreen" },
        
        # 新窗口/标签页
        { key = "t", mods = "control|shift", action = "CreateWindow" },
        { key = "w", mods = "control|shift", action = "CloseWindow" },
        
        # 标签页导航
        { key = "tab", mods = "control", action = "SelectNextTab" },
        { key = "tab", mods = "control|shift", action = "SelectPrevTab" },
        
        # 数字键切换标签页
        { key = "1", mods = "control", action = "SelectTab", args = "0" },
        { key = "2", mods = "control", action = "SelectTab", args = "1" },
        { key = "3", mods = "control", action = "SelectTab", args = "2" },
        { key = "4", mods = "control", action = "SelectTab", args = "3" },
        { key = "5", mods = "control", action = "SelectTab", args = "4" },
        
        # 滚动
        { key = "page_up", mods = "shift", action = "ScrollPageUp" },
        { key = "page_down", mods = "shift", action = "ScrollPageDown" },
        { key = "home", mods = "shift", action = "ScrollToTop" },
        { key = "end", mods = "shift", action = "ScrollToBottom" },
        
        # 搜索
        { key = "f", mods = "control|shift", action = "SearchForward" },
        { key = "b", mods = "control|shift", action = "SearchBackward" },
      ]
      
      # 行为设置
      [behavior]
      # 退出确认
      confirm-before-quit = false
      
      # 窗口关闭行为
      quit-after-last-window-closed = false
      
      # 隐藏光标时间 (毫秒)
      hide-cursor-when-typing = true
      
      # 光标样式
      [cursor]
      style = "Block"  # 可选: "Block", "Underline", "Beam"
      blinking = true
      
      # 滚动设置
      [scroll]
      # 滚动历史行数
      history = 10000
      
      # 自动滚动到底部
      auto-scroll = true
      
      # 性能设置
      [performance]
      # 禁用未聚焦时的渲染
      disable-renderer-when-unfocused = true
      
      # 启用六边形字体渲染
      use-fork = false
      
      # 导航设置
      [navigation]
      # 色彩模式
      color-automation = []
      
      # 点击URL行为
      clickable-url = true
      
      # 开发者设置
      [developer]
      # 启用日志
      log-level = "OFF"  # 可选: "OFF", "ERROR", "WARN", "INFO", "DEBUG", "TRACE"
      
      # 启用开发者工具
      enable-fps-counter = false
    '';
    
    # Shell 集成配置
    programs.fish.shellInit = lib.mkIf config.programs.fish.enable ''
      # Rio Terminal 特定配置
      if test "$TERM_PROGRAM" = "rio"
        # 设置终端特定环境变量
        set -gx RIO_TERMINAL 1
        
        # 优化颜色显示
        set -gx COLORTERM truecolor
        
        # Rio 专用别名
        alias rio-config="$EDITOR ~/.config/rio/config.toml"
        
        # 快速重启 Rio (如果支持)
        function rio-restart
          echo "请手动重启 Rio 终端以应用新配置"
        end
      end
    '';
    
    # Bash 集成配置
    programs.bash.initExtra = lib.mkIf config.programs.bash.enable ''
      # Rio Terminal 检测和配置
      if [ "$TERM_PROGRAM" = "rio" ]; then
        export RIO_TERMINAL=1
        export COLORTERM=truecolor
        
        # Rio 配置别名
        alias rio-config='$EDITOR ~/.config/rio/config.toml'
        
        # 配置重载函数
        rio-restart() {
          echo "请手动重启 Rio 终端以应用新配置"
        }
      fi
    '';
    
    # 桌面集成
    xdg.desktopEntries.rio = lib.mkIf pkgs.stdenv.isLinux {
      name = "Rio Terminal";
      comment = "Modern GPU-accelerated terminal emulator";
      exec = "${pkgs.rio}/bin/rio";
      icon = "terminal";
      terminal = false;
      type = "Application";
      categories = [ "System" "TerminalEmulator" ];
      mimeType = [ "application/x-terminal-emulator" ];
    };
    
    # 默认终端设置 (可选)
    home.sessionVariables = {
      # 如果想要 Rio 作为默认终端
      # TERMINAL = "${pkgs.rio}/bin/rio";
    };
  };
}
