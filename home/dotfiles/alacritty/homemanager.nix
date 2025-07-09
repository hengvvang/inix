{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.alacritty.enable && 
                    config.myHome.dotfiles.alacritty.method == "homemanager") {
    programs.alacritty = {
      enable = true;
      settings = {
        # 环境变量
        env.TERM = "alacritty";

        # 窗口设置 - 现代化外观
        window = {
          dimensions = {
            columns = 120;
            lines = 30;
          };
          padding = {
            x = 8;
            y = 8;
          };
          decorations = "full";
          opacity = 0.95;
          startup_mode = "Windowed";
          title = "Alacritty";
          class = {
            instance = "Alacritty";
            general = "Alacritty";
          };
        };

        # 字体设置 - 舒适的编程字体
        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Italic";
          };
          bold_italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold Italic";
          };
          size = 13;
        };

        # 滚动设置 - 人体工程学优化
        scrolling = {
          history = 10000;
          multiplier = 3;
        };

        # 光标设置 - 现代化光标
        cursor = {
          style = {
            shape = "Block";
            blinking = "On";
          };
          blink_interval = 500;
          unfocused_hollow = true;
          thickness = 0.15;
        };

        # 实时重载配置
        general.live_config_reload = true;

        # 鼠标设置 - 人体工程学优化
        mouse = {
          hide_when_typing = true;
          bindings = [
            { mouse = "Middle"; action = "PasteSelection"; }
            { mouse = "Right"; action = "Copy"; }
          ];
        };

        # 选择设置
        selection = {
          semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
          save_to_clipboard = true;
        };

        # 键位绑定 - 主流快捷键
        keyboard.bindings = [
          # 基本操作
          { key = "C"; mods = "Control|Shift"; action = "Copy"; }
          { key = "V"; mods = "Control|Shift"; action = "Paste"; }
          { key = "N"; mods = "Control|Shift"; action = "SpawnNewInstance"; }
          { key = "Q"; mods = "Control|Shift"; action = "Quit"; }
          
          # 字体大小调整
          { key = "Plus"; mods = "Control|Shift"; action = "IncreaseFontSize"; }
          { key = "Minus"; mods = "Control|Shift"; action = "DecreaseFontSize"; }
          { key = "Key0"; mods = "Control|Shift"; action = "ResetFontSize"; }
          
          # 全屏
          { key = "F11"; action = "ToggleFullscreen"; }
          
          # Vi 模式
          { key = "Space"; mods = "Control|Shift"; action = "ToggleViMode"; }
        ];

        # 主题配置 - Tokyo Night (现代化暗色主题)
        colors = {
          primary = {
            background = "#1a1b26";
            foreground = "#c0caf5";
          };
          normal = {
            black = "#15161e";
            red = "#f7768e";
            green = "#9ece6a";
            yellow = "#e0af68";
            blue = "#7aa2f7";
            magenta = "#bb9af7";
            cyan = "#7dcfff";
            white = "#a9b1d6";
          };
          bright = {
            black = "#414868";
            red = "#f7768e";
            green = "#9ece6a";
            yellow = "#e0af68";
            blue = "#7aa2f7";
            magenta = "#bb9af7";
            cyan = "#7dcfff";
            white = "#c0caf5";
          };
          indexed_colors = [
            { index = 16; color = "#ff9e64"; }
            { index = 17; color = "#db4b4b"; }
          ];
        };

        # 性能设置
        debug = {
          render_timer = false;
          persistent_logging = false;
          log_level = "Warn";
          print_events = false;
        };
      };
    };
  };
}
