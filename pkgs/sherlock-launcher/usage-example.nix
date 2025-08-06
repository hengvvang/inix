# Sherlock Launcher 使用示例 - macOS Tahoe 风格
# 在 Home Manager 或 NixOS 配置中集成 Sherlock Launcher
# 配置符合 macOS Tahoe 设计语言的现代化界面

{ config, pkgs, ... }:

{
  # Home Manager 方式配置 Sherlock Launcher
  programs.sherlock = {
    enable = true;
    package = pkgs.sherlock-launcher;
    
    settings = {
      # 主配置文件 - macOS Tahoe 风格
      config = {
        # 外观配置 - 现代 macOS 风格
        appearance = {
          width = 800;                    # 适中的窗口宽度，符合 macOS 比例
          height = 520;                   # 黄金比例高度
          gsk_renderer = "ngl";           # 使用现代 OpenGL 渲染器
          icon_size = 24;                 # macOS 风格图标大小
          use_base_css = true;            # 启用基础样式
          opacity = 0.95;                 # 轻微透明度，模拟毛玻璃效果
          mod_key_ascii = ["⇧" "⇪" "⌃" "⌘" "⌥" "✦" "⌘" "⌘"]; # macOS 风格修饰键符号
        };

        # 行为配置 - 符合 macOS 交互习惯
        behavior = {
          animate = true;                 # 启用动画，符合 macOS 流畅体验
          use_xdg_data_dir_icons = false; # 使用系统图标
          global_prefix = null;
          global_flags = null;
        };

        # 默认应用 - 配置 macOS 风格应用
        default_apps = {
          terminal = "alacritty";         # 现代终端
          calendar_client = "thunderbird";
          teams = "teams-for-linux --enable-features=UseOzonePlatform --ozone-platform=wayland --url {meeting_url}";
          browser = "firefox";
        };

        # 单位配置 - 本地化设置
        units = {
          lengths = "meter";
          weights = "kg"; 
          volumes = "l";
          temperatures = "C";
          currency = "usd";               # 根据需要调整货币
        };

        # 调试配置
        debug = {
          try_suppress_errors = false;
          try_suppress_warnings = false;
          app_paths = [];
        };

        # 状态栏配置
        status_bar = {
          enable = true;
        };

        # 文件路径配置 - 使用 external 模式
        files = {
          config = "${config.xdg.configHome}/sherlock/config.toml";
          css = "${config.xdg.configHome}/sherlock/main.css";
          fallback = "${config.xdg.configHome}/sherlock/fallback.json";
          alias = "${config.xdg.configHome}/sherlock/sherlock_alias.json";
          ignore = "${config.xdg.configHome}/sherlock/sherlockignore";
          actions = "${config.xdg.configHome}/sherlock/sherlock_actions.json";
        };

        # 缓存配置
        caching = {
          cache = "${config.xdg.cacheHome}/sherlock_desktop_cache.json";
        };

        # 运行时配置
        runtime = {
          multi = false;
          display_raw = false;
          center = false;
          photo_mode = false;
          daemonize = false;
        };
      };

      # macOS Tahoe 风格的 CSS 样式
      style = ''
        /* macOS Tahoe 风格主题 - 现代毛玻璃设计 */
        :root {
          /* macOS Tahoe 颜色系统 */
          --background: hsl(220, 13%, 18%);          /* 深色背景，类似 macOS 暗色模式 */
          --background-blur: hsla(220, 13%, 18%, 0.85); /* 毛玻璃背景 */
          --foreground: hsl(220, 13%, 22%);          /* 次级背景 */
          --surface: hsl(220, 13%, 25%);             /* 表面颜色 */
          --text: hsl(220, 9%, 85%);                 /* 主文本 */
          --text-secondary: hsl(220, 9%, 65%);       /* 次级文本 */
          --text-active: hsl(220, 20%, 95%);         /* 活跃文本 */
          --border: hsl(220, 13%, 30%);              /* 边框颜色 */
          --border-focus: hsl(220, 60%, 50%);        /* 焦点边框 */
          
          /* macOS 系统强调色 */
          --accent: hsl(212, 100%, 50%);             /* 系统蓝色 */
          --accent-hover: hsl(212, 100%, 55%);       /* 悬停蓝色 */
          --success: hsl(120, 50%, 50%);             /* 成功绿色 */
          --warning: hsl(38, 90%, 60%);              /* 警告橙色 */
          --error: hsl(0, 70%, 60%);                 /* 错误红色 */
          
          /* 毛玻璃效果 */
          --glass-background: hsla(220, 13%, 18%, 0.8);
          --glass-border: hsla(220, 13%, 50%, 0.2);
          
          /* 阴影系统 */
          --shadow-light: 0 2px 10px hsla(220, 13%, 0%, 0.1);
          --shadow-medium: 0 4px 20px hsla(220, 13%, 0%, 0.15);
          --shadow-heavy: 0 8px 30px hsla(220, 13%, 0%, 0.25);
          
          /* 圆角系统 */
          --radius-small: 6px;
          --radius-medium: 10px;
          --radius-large: 16px;
        }

        /* 主窗口 - macOS 风格毛玻璃效果 */
        window:not(#backdrop) {
          background: var(--glass-background);
          backdrop-filter: blur(20px) saturate(1.2);
          border: 1px solid var(--glass-border);
          border-radius: var(--radius-large);
          box-shadow: var(--shadow-heavy);
          color: var(--text);
        }

        /* 搜索栏 - macOS 风格设计 */
        #search-bar {
          background: var(--surface);
          border: 1px solid var(--border);
          border-radius: var(--radius-medium);
          color: var(--text);
          font-size: 16px;
          font-weight: 400;
          padding: 12px 20px;
          margin: 16px;
          min-height: 20px;
          transition: all 0.2s ease;
          box-shadow: var(--shadow-light);
        }

        #search-bar:focus {
          border-color: var(--accent);
          box-shadow: 0 0 0 3px hsla(212, 100%, 50%, 0.15);
          outline: none;
        }

        #search-bar-holder {
          border: none;
          background: transparent;
        }

        /* 瓦片样式 - macOS 列表项风格 */
        .tile {
          background: var(--surface);
          border: 1px solid transparent;
          border-radius: var(--radius-medium);
          margin: 4px 16px;
          padding: 12px 16px;
          min-height: 60px;
          transition: all 0.15s ease;
          box-shadow: var(--shadow-light);
        }

        .tile:hover {
          background: var(--foreground);
          border-color: var(--border);
          transform: translateY(-1px);
          box-shadow: var(--shadow-medium);
        }

        .tile:selected {
          background: var(--accent);
          border-color: var(--accent);
          color: var(--text-active);
          box-shadow: var(--shadow-medium);
        }

        .tile:selected * {
          color: var(--text-active);
        }

        /* 图标样式 - macOS 图标系统 */
        image {
          border-radius: var(--radius-small);
          margin-right: 12px;
        }

        .tile:selected image {
          filter: brightness(1.1) contrast(1.1);
        }

        /* 标签系统 - macOS 标签风格 */
        .tag-start,
        .tag-end {
          background: var(--foreground);
          border: 1px solid var(--border);
          border-radius: var(--radius-small);
          color: var(--text-secondary);
          font-size: 11px;
          font-weight: 500;
          padding: 4px 8px;
          margin-left: 8px;
        }

        .tile:selected .tag-start {
          background: hsla(212, 100%, 100%, 0.2);
          border-color: hsla(212, 100%, 100%, 0.3);
          color: var(--text-active);
        }

        .tile:selected .tag-end {
          background: var(--success);
          border-color: var(--success);
          color: white;
        }

        /* 快捷键显示 - macOS 风格 */
        #shortcut-holder {
          background: var(--foreground);
          border: 1px solid var(--border);
          border-radius: var(--radius-small);
          padding: 4px 8px;
          margin-right: 12px;
          box-shadow: var(--shadow-light);
        }

        #shortcut,
        #shortcut-modkey {
          background: transparent;
          color: var(--text-secondary);
          font-size: 12px;
          font-weight: 500;
        }

        /* 滚动条 - macOS 风格 */
        scrollbar {
          background: transparent;
          border: none;
          width: 8px;
        }

        scrollbar slider {
          background: var(--border);
          border-radius: 4px;
          border: none;
          min-height: 40px;
        }

        scrollbar slider:hover {
          background: var(--text-secondary);
        }

        /* 上下文菜单 - macOS 风格 */
        #context-menu {
          background: var(--glass-background);
          backdrop-filter: blur(20px) saturate(1.2);
          border: 1px solid var(--glass-border);
          border-radius: var(--radius-medium);
          box-shadow: var(--shadow-heavy);
          padding: 8px;
          margin: 4px;
        }

        #context-menu row {
          border-radius: var(--radius-small);
          color: var(--text);
          padding: 8px 12px;
          transition: all 0.15s ease;
        }

        #context-menu row:hover {
          background: var(--accent);
          color: var(--text-active);
        }

        #context-menu label {
          color: inherit;
          font-size: 14px;
          font-weight: 400;
        }

        /* 状态栏 - macOS 底部栏风格 */
        .status-bar {
          background: var(--foreground);
          border-top: 1px solid var(--border);
          border-radius: 0 0 var(--radius-large) var(--radius-large);
          padding: 8px 16px;
        }

        .status-bar label {
          color: var(--text-secondary);
          font-size: 12px;
        }

        .status-bar #shortcut-key,
        .status-bar #shortcut-modifier {
          background: var(--surface);
          border: 1px solid var(--border);
          border-radius: var(--radius-small);
          color: var(--text);
          font-size: 11px;
          font-weight: 500;
          margin: 0 2px;
          padding: 2px 6px;
        }

        /* 动画 - macOS 流畅动画 */
        .tile.animate {
          animation: macosSlideIn 0.25s cubic-bezier(0.2, 0, 0, 1) forwards;
          opacity: 0;
          transform: translateY(10px);
        }

        @keyframes macosSlideIn {
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }

        /* 特殊瓦片类型样式 */
        .calc-tile {
          background: linear-gradient(135deg, var(--surface) 0%, var(--foreground) 100%);
        }

        .weather-tile {
          background: linear-gradient(135deg, hsl(212, 100%, 40%) 0%, hsl(212, 100%, 60%) 100%);
          color: white;
        }

        .timer-tile {
          background: linear-gradient(135deg, var(--success) 0%, hsl(120, 50%, 60%) 100%);
          color: white;
        }

        /* 响应式设计 - 适应不同屏幕 */
        @media (max-width: 900px) {
          window:not(#backdrop) {
            border-radius: var(--radius-medium);
            margin: 8px;
          }
          
          #search-bar {
            margin: 12px;
            font-size: 15px;
          }
          
          .tile {
            margin: 3px 12px;
            padding: 10px 14px;
          }
        }

        /* 深色模式优化 */
        @media (prefers-color-scheme: dark) {
          :root {
            --background: hsl(220, 13%, 16%);
            --foreground: hsl(220, 13%, 20%);
            --surface: hsl(220, 13%, 23%);
          }
        }
      '';

      # 忽略文件配置
      ignore = ''
        # 系统应用和不需要的项目
        .DS_Store
        System*
        *.tmp
        *.cache
      '';

      # 自定义启动器配置
      launchers = [
        {
          name = "Sherlock Settings";
          description = "打开 Sherlock 设置";
          command = "sherlock init";
          icon = "preferences-system";
          tags = ["settings" "config"];
        }
        {
          name = "重新加载主题";
          description = "重新加载 Sherlock 主题";
          command = "pkill sherlock && sherlock";
          icon = "view-refresh";
          tags = ["reload" "theme"];
        }
      ];

      # 别名配置 - 快速访问
      aliases = {
        "设置" = {
          name = "系统设置";
          command = "gnome-control-center";
          icon = "preferences-system";
        };
        "终端" = {
          name = "终端";
          command = "alacritty";
          icon = "terminal";
        };
        "文件" = {
          name = "文件管理器";
          command = "nautilus";
          icon = "folder";
        };
        "浏览器" = {
          name = "Firefox";
          command = "firefox";
          icon = "firefox";
        };
      };
    };
  };

  # 可选：为 Hyprland 配置键绑定 - macOS 风格快捷键
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, SPACE, exec, sherlock"                    # ⌘+Space - Spotlight 风格
      "SUPER_SHIFT, SPACE, exec, sherlock -sm emoji"    # ⌘+⇧+Space - 表情符号
      "SUPER, RETURN, exec, sherlock -sm calc"          # ⌘+Return - 计算器
      "SUPER, P, exec, sherlock -sm pm"                 # ⌘+P - 电源菜单
      "SUPER, T, exec, sherlock -sm pomodoro"           # ⌘+T - 番茄钟
      "SUPER_SHIFT, RETURN, exec, sherlock --multi"     # ⌘+⇧+Return - 多选模式
    ];
  };

  # 在其他桌面环境中的键绑定配置示例
  # services.sxhkd.keybindings = {
  #   "super + space" = "sherlock";
  #   "super + shift + space" = "sherlock -sm emoji";
  #   "super + Return" = "sherlock -sm calc";
  # };

  # 确保必要的字体可用于 macOS 风格
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # macOS 风格字体
    sf-pro
    # 或使用开源替代
    inter
    jetbrains-mono
    
    # 图标主题
    papirus-icon-theme
    
    # 其他相关工具
    wl-clipboard          # Wayland 剪贴板支持
    libnotify             # 通知支持
  ];
}