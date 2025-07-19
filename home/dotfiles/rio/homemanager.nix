{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "homemanager") {
    # 部署主题文件到正确位置
    home.file.".config/rio/themes".source = ./configs/themes;
    
    programs.rio = {
      enable = true;
      package = pkgs.rio;
      
      settings = {
        # === 基础外观配置 ===
        # 主题设置 - 禁用内联颜色定义，使用主题文件
        theme = "rose-pine";  # 取消注释以使用主题，需要主题文件
        
        # 确认退出提示 - 防止意外关闭
        confirm-before-quit = true;
        
        # 行高设置 - 改善可读性
        line-height = 1.1;
        
        # 隐藏鼠标光标当输入时
        hide-mouse-cursor-when-typing = true;
        
        # 选择前景色忽略设置
        ignore-selection-foreground-color = false;
        
        # === 字体配置 ===
        fonts = {
          # 字体大小
          size = 14;
          
          # 字体特性 - 启用编程字体连字等
          features = ["ss02" "ss03" "ss05"];  # 常用的 Stylistic Sets
          
          # 使用内置可绘制字符 - 更好的性能
          use-drawable-chars = true;
          
          # 字体查找警告
          disable-warnings-not-found = false;
          
          # 启用字体提示
          hinting = true;
          
          # 常规字体
          regular = {
            # family = "Noto Sans Mono";
            family = "Monaspace Argon Frozen";
            style = "Normal";
            width = "Normal";
            weight = 300;
          };
          
          # 粗体字体
          bold = {
            # family = "Noto Sans Mono";
            family = "Monaspace Argon Frozen";
            style = "Normal"; 
            width = "Normal";
            weight = 500;
          };
          
          # 斜体字体
          italic = {
            # family = "Noto Sans Mono";
            family = "Monaspace Argon Frozen";
            style = "Italic";
            width = "Normal";
            weight = 300;
          };
          
          # 粗斜体字体
          bold-italic = {
            # family = "Noto Sans Mono";
            family = "Monaspace Argon Frozen";
            style = "Italic";
            width = "Normal";
            weight = 500;
          };
          
          # 表情符号字体 (可选)
          # emoji = {
          #   family = "Noto Color Emoji";
          # };
          
          # 符号映射 - 用于 Powerline 等特殊字符
          symbol-map = [
            # Powerline 符号
            { start = "E0B0"; end = "E0BF"; font-family = "FiraCode Nerd Font"; }
            # 其他图标符号
            { start = "E000"; end = "F8FF"; font-family = "FiraCode Nerd Font"; }
          ];
        };
        
        # === 光标配置 ===
        cursor = {
          shape = "beam";  # 选项: 'block', 'underline', 'beam'
          blinking = true;
          blinking-interval = 800;  # 闪烁间隔 (350-1200ms)
        };
        
        # === 窗口配置 ===
        window = {
          # 初始窗口尺寸
          width = 1000;
          height = 700;
          
          # 窗口模式: "Windowed", "Maximized", "Fullscreen"
          mode = "Windowed";
          
          # 窗口装饰: "Enabled", "Disabled", "Transparent", "Buttonless"
          decorations = "Enabled";
          
          # 窗口透明度 (0.0-1.0)
          opacity = 1.0;
          
          # 背景模糊效果 - 需要重启生效
          blur = true;
          
          # macOS 特定配置
          # macos-use-unified-titlebar = false;
          # macos-use-shadow = true;
          
          # Windows 特定配置
          # windows-corner-preference = "Round";
          # windows-use-undecorated-shadow = false;
          # windows-use-no-redirection-bitmap = false;
        };
        
        # === 导航/标签配置 ===
        navigation = {
          # 导航模式: "Bookmark", "BottomTab", "TopTab", "Plain", "NativeTab"(macOS)
          mode = "Bookmark";
          
          # 启用分屏功能
          use-split = true;
          
          # 未聚焦分屏的透明度
          unfocused-split-opacity = 0.8;
          
          # 单标签时隐藏导航栏
          hide-if-single = true;
          
          # 新标签使用当前工作目录
          current-working-directory = true;
          
          # 用分屏打开配置文件
          # open-config-with-split = false;
          
          # 标签颜色自动化
          color-automation = [
            # 当运行 nvim 时标签变红
            { program = "nvim"; color = "#FF6B6B"; }
            { program = "vim"; color = "#FF6B6B"; }
            # 当运行 git 相关命令时标签变绿
            { program = "git"; color = "#51CF66"; }
            { program = "lazygit"; color = "#51CF66"; }
            # 当在项目目录时标签变蓝
            # { path = "/home/hengvvang/projects"; color = "#339AF0"; }
          ];
        };
        
        # === 滚动配置 ===
        scroll = {
          multiplier = 3.0;  # 滚动倍数
          divider = 1.0;     # 滚动除数
        };
        
        # === 渲染器配置 ===
        renderer = {
          # 性能模式: "High", "Low"
          performance = "High";
          
          # 渲染后端: "Automatic", "GL", "Vulkan", "DX12", "Metal"
          backend = "Automatic";
          
          # 失焦时禁用渲染
          disable-unfocused-render = true;
          
          # 被遮挡时禁用渲染
          disable-occluded-render = true;
          
          # 渲染策略: "events", "game"
          strategy = "events";
          
          # 目标帧率 - 仅在启用时生效
          # target-fps = 60;
          
          # 着色器滤镜 - 需要非 GL 后端
          # filters = [
          #   "NewPixieCrt"  # 内置 CRT 效果
          # ];
        };
        
        # === Shell 配置 ===
        shell = {
          program = "/run/current-system/sw/bin/fish";
          args = ["--login"];
        };
        
        # === 键盘配置 ===
        keyboard = {
          # 禁用 ALT 键的控制序列
          disable-ctlseqs-alt = false;
          
          # 启用 IME 光标定位 - 改善中文输入体验
          ime-cursor-positioning = true;
        };
        
        # === 窗口标题配置 ===
        title = {
          # 标题模板 - 显示程序名和路径
          content = "{{ title || program }} - {{ columns }}x{{ lines }}";
          
          # 初始占位符
          placeholder = "Rio Terminal";
        };
        
        # === 边距配置 ===
        padding-x = 8;           # 水平边距
        padding-y = [8 8];       # 垂直边距 [top, bottom]
        
        # === 环境变量 ===
        env-vars = [
          "TERM=xterm-256color"
          "COLORTERM=truecolor"
        ];
        
        # === 开发者选项 ===
        developer = {
          log-level = "OFF";        # 日志级别: OFF, ERROR, WARN, INFO, DEBUG, TRACE
          enable-log-file = false;  # 启用日志文件
        };
        
        # === 其他配置 ===
        # 工作目录 - 需要 use-fork = false
        # working-dir = "/home/hengvvang";
        
        # 进程分叉模式 - Linux 默认 true
        use-fork = true;
        
        # 使用亮色绘制粗体文本
        draw-bold-text-with-light-colors = false;
        
        # macOS 选项键作为 Alt 键: "both", "left", "right"
        # option-as-alt = "left";
        
        # === 编辑器配置 ===
        editor = {
          program = "vim";  # 配置文件编辑器
          args = [];
        };
        
        # === 平台特定配置 ===
        platform = {
          # Linux 特定 shell 配置
          linux.shell.program = "/run/current-system/sw/bin/fish";
          linux.shell.args = ["--login"];
          
          # 可以添加其他平台配置
          # windows.shell.program = "pwsh";
          # windows.shell.args = ["-l"];
        };
      };
    };
  };
}
