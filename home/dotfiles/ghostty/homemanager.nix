{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "homemanager") {
    programs.ghostty = {
      enable = true;
      package = pkgs.ghostty;
      
      # 主要配置设置
      settings = {
        # ==================== 字体配置 ====================
        # font-family = "FiraCode Nerd Font";  # 主字体，注释掉使用系统默认
        font-size = 12;                        # 字体大小（磅）
        # font-thicken = false;                 # 字体加粗（仅 macOS）
        # font-synthetic-style = true;          # 启用字体合成样式
        
        # 字体特性（支持连字和样式变体）
        font-feature = [
          "+ss01"  # 连字样式集 1
          "+ss02"  # 连字样式集 2
          "+ss03"  # 连字样式集 3
          "+ss04"  # 连字样式集 4
          "+ss05"  # 连字样式集 5
          "+ss06"  # 连字样式集 6
          "+ss07"  # 连字样式集 7
          "+ss08"  # 连字样式集 8
          "+ss09"  # 连字样式集 9
          "+ss10"  # 连字样式集 10
          "+cv01"  # 字符变体 1
          "+cv02"  # 字符变体 2
          "+cv05"  # 字符变体 5
          "+cv09"  # 字符变体 9
          "+cv10"  # 字符变体 10
          "+cv11"  # 字符变体 11
          "+cv12"  # 字符变体 12
          "+cv13"  # 字符变体 13
          "+cv14"  # 字符变体 14
        ];
        
        # ==================== 窗口配置 ====================
        window-padding-x = 8;                  # 窗口水平内边距
        window-padding-y = 8;                  # 窗口垂直内边距
        window-padding-balance = true;         # 自动平衡内边距
        window-padding-color = "background";   # 内边距颜色
        window-decoration = true;              # 窗口装饰（标题栏等）
        window-title-font-family = "FiraCode Nerd Font";  # 标题栏字体
        # window-theme = "auto";                # 窗口主题：auto/system/light/dark
        # window-inherit-working-directory = true;  # 新窗口继承工作目录
        # window-inherit-font-size = false;    # 新窗口继承字体大小
        # window-vsync = true;                  # 垂直同步（减少撕裂）
        
        # ==================== 终端行为配置 ====================
        scrollback-limit = 100000;             # 回滚缓冲区大小（字节）
        mouse-hide-while-typing = true;        # 输入时隐藏鼠标
        copy-on-select = false;                # 选择时自动复制
        confirm-close-surface = false;         # 关闭终端前确认
        shell-integration = "fish";            # shell 集成
        command = "fish";                      # 默认命令/shell
        working-directory = "inherit";         # 工作目录：inherit/home
        # wait-after-command = false;          # 命令退出后保持终端开启
        # abnormal-command-exit-runtime = 2000; # 异常退出检测时间（毫秒）
        
        # ==================== 显示和主题配置 ====================
        theme = "catppuccin-macchiato";        # 使用自定义主题
        # background-opacity = 1.0;            # 背景透明度
        # background-blur = false;              # 背景模糊
        unfocused-split-opacity = 0.7;        # 未聚焦分割窗口透明度
        # minimum-contrast = 1.0;              # 最小对比度
        # bold-is-bright = false;               # 粗体使用亮色
        
        # ==================== 光标配置 ====================
        cursor-style = "block";               # 光标样式：block/bar/underline/block_hollow
        cursor-style-blink = false;           # 光标闪烁
        # cursor-opacity = 1.0;                # 光标透明度
        # cursor-click-to-move = false;        # Alt+点击移动光标
        
        # ==================== 音效和视觉反馈 ====================
        # audio-bell = false;                  # 音频铃声
        # visual-bell = true;                  # 视觉铃声
        # visual-bell-color = "f5a97f";        # 视觉铃声颜色
        # visual-bell-duration = 100;          # 视觉铃声持续时间
        
        # ==================== 鼠标配置 ====================
        # mouse-shift-capture = false;         # Shift+鼠标点击捕获
        # mouse-scroll-multiplier = 1.0;       # 鼠标滚轮倍数
        # focus-follows-mouse = false;          # 鼠标焦点跟随
        
        # ==================== 调整大小和布局 ====================
        resize-overlay = true;                 # 调整大小时显示叠加层
        resize-overlay-position = "center";    # 叠加层位置
        resize-overlay-duration = 500;         # 叠加层显示时长（毫秒）
        
        # ==================== 剪贴板配置 ====================
        # clipboard-read = "ask";               # 读取剪贴板权限：ask/allow/deny
        # clipboard-write = "allow";            # 写入剪贴板权限
        # clipboard-trim-trailing-spaces = true; # 复制时去除尾随空格
        # clipboard-paste-protection = true;    # 粘贴保护（防止恶意命令）
        # clipboard-paste-bracketed-safe = true; # 括号粘贴安全模式
        
        # ==================== 链接和标题配置 ====================
        # link-url = true;                      # 启用 URL 链接检测
        # title-report = false;                 # 允许程序查询标题（安全风险）
        
        # ==================== Shell 集成功能 ====================
        # shell-integration-features = "cursor,sudo,title"; # Shell 集成功能
        
        # ==================== 高级配置 ====================
        # term = "xterm-256color";              # TERM 环境变量
        # image-storage-limit = 320000000;      # 图像存储限制（字节）
        # grapheme-width-method = "unicode";    # 字符宽度计算方法
        # osc-color-report-format = "16-bit";   # OSC 颜色报告格式
        
        # ==================== 键绑定示例 ====================
        # 可以添加自定义键绑定
        # keybind = [
        #   "ctrl+shift+c=copy_to_clipboard"
        #   "ctrl+shift+v=paste_from_clipboard"
        #   "ctrl+shift+t=new_tab"
        #   "ctrl+shift+w=close_surface"
        # ];
      };
      
      # ==================== 自定义主题定义 ====================
      themes = {
        catppuccin-macchiato = {
          # 基本颜色
          background = "24273a";              # 背景色
          foreground = "cad3f5";              # 前景色（文本颜色）
          cursor-color = "f4dbd6";            # 光标颜色
          selection-background = "5b6078";    # 选择背景色
          selection-foreground = "cad3f5";    # 选择前景色
          
          # 16 色调色板（标准终端颜色）
          palette = [
            "0=#494d64"   # 黑色
            "8=#5b6078"   # 亮黑色（灰色）
            "1=#ed8796"   # 红色
            "9=#ed8796"   # 亮红色
            "2=#a6da95"   # 绿色
            "10=#a6da95"  # 亮绿色
            "3=#eed49f"   # 黄色
            "11=#eed49f"  # 亮黄色
            "4=#8aadf4"   # 蓝色
            "12=#8aadf4"  # 亮蓝色
            "5=#f5bde6"   # 品红色
            "13=#f5bde6"  # 亮品红色
            "6=#8bd5ca"   # 青色
            "14=#8bd5ca"  # 亮青色
            "7=#b8c0e0"   # 白色
            "15=#a5adcb"  # 亮白色
          ];
        };
        
        # 可以定义更多主题
        # gruvbox-dark = {
        #   background = "282828";
        #   foreground = "ebdbb2";
        #   palette = [
        #     "0=#282828" "8=#928374"
        #     "1=#cc241d" "9=#fb4934"
        #     "2=#98971a" "10=#b8bb26"
        #     "3=#d79921" "11=#fabd2f"
        #     "4=#458588" "12=#83a598"
        #     "5=#b16286" "13=#d3869b"
        #     "6=#689d6a" "14=#8ec07c"
        #     "7=#a89984" "15=#ebdbb2"
        #   ];
        # };
      };
      
      # ==================== Home Manager 集成选项 ====================
      # 启用各种 shell 集成（自动配置 shell 环境）
      enableFishIntegration = true;          # Fish shell 集成
      enableBashIntegration = true;          # Bash shell 集成
      enableZshIntegration = true;           # Zsh shell 集成
      
      # ==================== 额外的 Home Manager 选项 ====================
      # clearDefaultKeybinds = false;         # 清除默认键绑定
      # installBatSyntax = false;             # 为 bat 安装 Ghostty 语法高亮
      # installVimSyntax = false;             # 为 Vim 安装 Ghostty 语法高亮
    };
    
    # ==================== 相关环境配置 ====================
    # 可以在这里添加相关的环境变量或其他配置
    # home.sessionVariables = {
    #   TERMINAL = "ghostty";
    # };
    
    # ==================== 示例键绑定配置 ====================
    # 如果需要全局快捷键，可以考虑使用系统级配置
    # 这些绑定会在 Ghostty 内部生效
    # programs.ghostty.settings.keybind = [
    #   # 标签管理
    #   "ctrl+shift+t=new_tab"
    #   "ctrl+shift+w=close_surface"
    #   "ctrl+page_down=next_tab"
    #   "ctrl+page_up=previous_tab"
    #   
    #   # 分割窗口
    #   "ctrl+shift+d=new_split:right"
    #   "ctrl+shift+shift+d=new_split:down"
    #   
    #   # 复制粘贴
    #   "ctrl+shift+c=copy_to_clipboard"
    #   "ctrl+shift+v=paste_from_clipboard"
    #   
    #   # 字体大小调整
    #   "ctrl+equal=increase_font_size:1"
    #   "ctrl+minus=decrease_font_size:1"
    #   "ctrl+zero=reset_font_size"
    #   
    #   # 窗口管理
    #   "f11=toggle_fullscreen"
    #   "ctrl+shift+n=new_window"
    # ];
  };
}
