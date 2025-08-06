{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "homemanager") {

    programs.rio = {
      enable = true;
      package = pkgs.rio;

      settings = {
        # === 基础外观配置 ===
        # 主题设置 - 禁用内联颜色定义，使用主题文件
        theme = "tokyo-night";  # 取消注释以使用主题，需要主题文件

        # 确认退出提示 - 防止意外关闭
        confirm-before-quit = false;

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
            family = "LXGW WenKai Mono";
            # family = "Noto Sans Mono";
            # family = "Source Code Pro";
            style = "Normal";
            width = "Normal";
            weight = 500;
          };

          # 粗体字体
          bold = {
            family = "LXGW WenKai Mono";
            # family = "Noto Sans Mono";
            style = "Normal";
            width = "Normal";
            weight = 700;
          };

          # 斜体字体
          italic = {
            family = "LXGW WenKai Mono";
            # family = "Noto Sans Mono";
            style = "Italic";
            width = "Normal";
            weight = 500;
          };

          # 粗斜体字体
          bold-italic = {
            family = "LXGW WenKai Mono";
            # family = "Noto Sans Mono";
            style = "Italic";
            width = "Normal";
            weight = 700;
          };

          # 表情符号字体 (可选)
          # emoji = {
          #   family = "Noto Color Emoji";
          # };

          # 符号映射 - 将特定 Unicode 范围的字符映射到 Nerd Font
          # 这样可以在使用中文字体的同时显示编程图标和符号
          symbol-map = [
            # === Nerd Font 核心图标范围 ===
            # 私有使用区域 - 大部分 Nerd Font 图标都在这里
            { start = "E000"; end = "F8FF"; font-family = "FiraCode Nerd Font"; }
            { start = "F0000"; end = "FFFFD"; font-family = "FiraCode Nerd Font"; }
            { start = "100000"; end = "10FFFD"; font-family = "FiraCode Nerd Font"; }

            # === 具体图标库 ===
            # Font Awesome - 最常用的图标库
            { start = "F000"; end = "F2E0"; font-family = "FiraCode Nerd Font"; }

            # Material Design Icons - Google 设计图标
            { start = "F500"; end = "FD46"; font-family = "FiraCode Nerd Font"; }

            # Octicons - GitHub 图标
            { start = "F400"; end = "F4A9"; font-family = "FiraCode Nerd Font"; }

            # Devicons - 开发工具图标
            { start = "E700"; end = "E7C5"; font-family = "FiraCode Nerd Font"; }

            # Codicons - VS Code 图标
            { start = "EA60"; end = "EBEB"; font-family = "FiraCode Nerd Font"; }

            # Weather Icons - 天气图标
            { start = "E300"; end = "E3EB"; font-family = "FiraCode Nerd Font"; }

            # Seti-UI + Custom - 文件类型图标
            { start = "E5FA"; end = "E6AC"; font-family = "FiraCode Nerd Font"; }

            # Font Logos - 品牌和技术 Logo
            { start = "F300"; end = "F372"; font-family = "FiraCode Nerd Font"; }

            # === Powerline 符号 ===
            # 用于状态栏和提示符的特殊字符
            { start = "E0A0"; end = "E0A3"; font-family = "FiraCode Nerd Font"; }
            { start = "E0B0"; end = "E0C8"; font-family = "FiraCode Nerd Font"; }
            { start = "E0CA"; end = "E0CA"; font-family = "FiraCode Nerd Font"; }
            { start = "E0CC"; end = "E0D7"; font-family = "FiraCode Nerd Font"; }

            # === Unicode 符号区域 ===
            # 箭头符号
            { start = "2190"; end = "21FF"; font-family = "FiraCode Nerd Font"; }

            # 数学操作符
            { start = "2200"; end = "22FF"; font-family = "FiraCode Nerd Font"; }

            # 技术符号 (包含电源符号等)
            { start = "2300"; end = "23FF"; font-family = "FiraCode Nerd Font"; }

            # 盒子绘制字符 - 用于表格和边框
            { start = "2500"; end = "257F"; font-family = "FiraCode Nerd Font"; }

            # 块元素 - 用于进度条等
            { start = "2580"; end = "259F"; font-family = "FiraCode Nerd Font"; }

            # 几何形状
            { start = "25A0"; end = "25FF"; font-family = "FiraCode Nerd Font"; }

            # 杂项符号 (包含很多常用符号)
            { start = "2600"; end = "26FF"; font-family = "FiraCode Nerd Font"; }

            # 装饰符号
            { start = "2700"; end = "27BF"; font-family = "FiraCode Nerd Font"; }

            # === 其他范围 ===
            # Heavy Angle Brackets
            { start = "E6AD"; end = "E6B1"; font-family = "FiraCode Nerd Font"; }

            # Box Drawing (扩展)
            { start = "E6B2"; end = "E6B9"; font-family = "FiraCode Nerd Font"; }

            # IEC Power Symbols
            { start = "23FB"; end = "23FE"; font-family = "FiraCode Nerd Font"; }
            { start = "2B58"; end = "2B58"; font-family = "FiraCode Nerd Font"; }
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
          decorations = "Disabled";  # 禁用窗口装饰以获得更简洁的外观

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
          unfocused-split-opacity = 0.7;

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
