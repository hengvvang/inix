{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable && 
                    config.myHome.dotfiles.alacritty.method == "homemanager") {
    programs.alacritty = {
      enable = true;
      
      # Alacritty 包选择 - 可指定特定版本
      # package = pkgs.alacritty;
      
      settings = {
        # === 窗口配置 ===
        window = {
          # 窗口尺寸 (列 x 行)
          dimensions = {
            columns = 120;    # 窗口宽度 (字符数)
            lines = 30;       # 窗口高度 (行数)
          };
          
          # 窗口位置 (可选，不设置则居中)
          # position = {
          #   x = 200;
          #   y = 200;
          # };
          
          # 窗口内边距
          padding = {
            x = 5;           # 水平内边距
            y = 5;           # 垂直内边距
          };
          
          # 动态内边距 - 自动调整以均匀分布额外空间
          dynamic_padding = true;
          
          # 窗口装饰
          decorations = "full";        # full, none, transparent, buttonless
          
          # 启动模式
          startup_mode = "Windowed";   # Windowed, Maximized, Fullscreen
          
          # 窗口标题
          title = "Alacritty";
          
          # 动态标题 - 根据当前程序更新标题
          dynamic_title = true;
          
          # 窗口类名 (Linux)
          class = {
            instance = "Alacritty";
            general = "Alacritty";
          };
          
          # 窗口透明度 (0.0 - 1.0)
          opacity = 0.95;
        };
        
        # === 滚动配置 ===
        scrolling = {
          # 历史缓冲区大小
          history = 10000;
          
          # 滚动倍数
          multiplier = 3;
        };
        
        # === 字体配置 ===
        font = {
          # 字体族 - 您可以根据需要修改
          normal = {
            family = "JetBrains Mono";       # 普通字体
            style = "Regular";
          };
          
          bold = {
            family = "JetBrains Mono";       # 粗体字体
            style = "Bold";
          };
          
          italic = {
            family = "JetBrains Mono";       # 斜体字体
            style = "Italic";
          };
          
          bold_italic = {
            family = "JetBrains Mono";       # 粗斜体字体
            style = "Bold Italic";
          };
          
          # 字体大小
          size = 12.0;
          
          # 字体偏移 (用于微调字体位置)
          offset = {
            x = 0;
            y = 0;
          };
          
          # 字形偏移 (用于微调字符间距)
          glyph_offset = {
            x = 0;
            y = 0;
          };
        };
        
        # === 颜色配置 ===
        colors = {
          # 主要颜色
          primary = {
            background = "#1e1e1e";          # 背景色 (深色主题)
            foreground = "#d4d4d4";          # 前景色 (浅色文字)
            
            # 暗淡颜色 (可选)
            # dim_foreground = "#828482";
          };
          
          # 光标颜色
          cursor = {
            text = "#1e1e1e";                # 光标上的文字颜色
            cursor = "#d4d4d4";              # 光标颜色
          };
          
          # 选择区域颜色
          selection = {
            text = "CellForeground";         # 选中文字颜色
            background = "#3a3a3a";          # 选中背景色
          };
          
          # 普通颜色 (0-7)
          normal = {
            black = "#1e1e1e";
            red = "#f44747";
            green = "#608b4e";
            yellow = "#dcdcaa";
            blue = "#569cd6";
            magenta = "#c678dd";
            cyan = "#56b6c2";
            white = "#d4d4d4";
          };
          
          # 明亮颜色 (8-15)
          bright = {
            black = "#808080";
            red = "#f44747";
            green = "#608b4e";
            yellow = "#dcdcaa";
            blue = "#569cd6";
            magenta = "#c678dd";
            cyan = "#56b6c2";
            white = "#ffffff";
          };
        };
        
        # === 终端配置 ===
        terminal = {
          # Shell 程序
          # shell = {
          #   program = "${pkgs.fish}/bin/fish";  # 使用 fish shell
          #   args = [ "--login" ];
          # };
          
          # 开启 OSC 52 剪贴板支持
          osc52 = "CopyPaste";               # Disabled, OnlyPaste, OnlyCopy, CopyPaste
        };
        
        # === 鼠标配置 ===
        mouse = {
          # 双击选择模式
          double_click = { threshold = 300; };
          triple_click = { threshold = 300; };
          
          # 隐藏鼠标延迟 (秒)
          hide_when_typing = false;
          
          # 鼠标绑定
          bindings = [
            # 中键粘贴
            { 
              mouse = "Middle"; 
              action = "PasteSelection"; 
            }
          ];
        };
        
        # === 键盘快捷键配置 ===
        keyboard = {
          bindings = [
            # 复制粘贴
            { key = "C"; mods = "Control|Shift"; action = "Copy"; }
            { key = "V"; mods = "Control|Shift"; action = "Paste"; }
            
            # 字体大小调整
            { key = "Plus"; mods = "Control"; action = "IncreaseFontSize"; }
            { key = "Minus"; mods = "Control"; action = "DecreaseFontSize"; }
            { key = "Key0"; mods = "Control"; action = "ResetFontSize"; }
            
            # 全屏切换
            { key = "F11"; mods = ""; action = "ToggleFullscreen"; }
            
            # 新建窗口/标签页 (需要支持)
            { key = "N"; mods = "Control|Shift"; action = "SpawnNewInstance"; }
            
            # 清屏
            { key = "L"; mods = "Control"; action = "ClearLogNotice"; }
            { key = "L"; mods = "Control"; chars = "\\x0c"; }
            
            # 搜索
            { key = "F"; mods = "Control|Shift"; action = "SearchForward"; }
            { key = "B"; mods = "Control|Shift"; action = "SearchBackward"; }
          ];
        };
        
        # === 选择配置 ===
        selection = {
          # 选择时自动保存到剪贴板
          save_to_clipboard = true;
        };
        
        # === 光标配置 ===
        cursor = {
          # 光标样式: Block, Underline, Beam
          style = {
            shape = "Block";                 # 光标形状
            blinking = "On";                 # 光标闪烁: Never, Off, On, Always
          };
          
          # 光标厚度 (仅对 Underline 和 Beam 有效)
          thickness = 0.15;
          
          # 未聚焦时光标样式
          unfocused_hollow = true;
        };
        
        # === 实时配置重载 ===
        live_config_reload = true;
        
        # === 工作目录 ===
        working_directory = "None";          # 启动目录，None 表示继承
        
        # === 环境变量 ===
        env = {
          TERM = "alacritty";                # 终端类型
          # TERM_PROGRAM = "alacritty";      # 终端程序标识
        };
        
        # === 调试配置 (生产环境建议关闭) ===
        debug = {
          render_timer = false;              # 渲染计时器
          persistent_logging = false;        # 持久化日志
          log_level = "Warn";               # 日志级别: Off, Error, Warn, Info, Debug, Trace
          print_events = false;             # 打印事件
          highlight_damage = false;         # 高亮损坏区域
          prefer_egl = false;               # 首选 EGL
        };
      };
      
      # === 主题配置 (可选) ===
      # 您可以选择一个预定义主题，这会覆盖上面的 colors 配置
      # theme = "Dracula";                   # 可用主题: https://github.com/alacritty/alacritty-theme
    };
  };
}
