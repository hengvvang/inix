{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "homemanager") {
    programs.yazi = {
      enable = true;
      
      # Shell integrations - 启用与shell的集成
      enableBashIntegration = true;  # 根据需要启用bash集成
      enableFishIntegration = true;   # 你使用fish shell，启用fish集成
      enableZshIntegration = true;   # 根据需要启用zsh集成
      enableNushellIntegration = true;  # 根据需要启用nushell集成
      
      # Shell wrapper name - shell包装器名称，默认为"ya"
      shellWrapperName = "ya";

      # 主要配置 - 对应yazi.toml
      settings = {
        # 管理器配置
        mgr = {
          # 布局比例 [父目录, 当前目录, 预览] - 可调整面板宽度比例
          ratio = [ 1 3 4 ];
          
          # 排序设置
          sort_by = "natural";        # 自然排序(1.md < 2.md < 10.md), 可选: "mtime", "size", "extension", "alphabetical", "random"
          sort_sensitive = false;     # 不区分大小写排序
          sort_reverse = false;       # 不反向排序
          sort_dir_first = true;      # 目录优先显示
          sort_translit = false;      # 不进行字符音译(用于匈牙利语等)
          
          # 显示设置
          show_hidden = false;        # 不显示隐藏文件，按 . 键可临时切换
          show_symlink = true;        # 显示符号链接路径
          linemode = "size";         # 行模式显示文件大小，可选: "none", "size", "mtime", "permissions", "owner"
          
          # 滚动设置
          scrolloff = 5;             # 光标上下保留的行数，大于屏幕一半则居中
          
          # 鼠标事件 - 插件系统可接收的鼠标事件类型
          mouse_events = [ "click" "scroll" ];  # 可选: "click", "scroll", "touch", "move", "drag"
          
          # 终端标题格式 - {cwd}表示当前工作目录
          title_format = "Yazi: {cwd}";
        };

        # 预览配置
        preview = {
          # 文本预览
          wrap = "no";               # 代码预览中不换行，可选: "yes", "no"
          tab_size = 4;              # Tab字符的宽度(空格数)
          
          # 图片预览
          max_width = 600;           # 图片预览最大宽度，更改后需运行 yazi --clear-cache
          max_height = 900;          # 图片预览最大高度
          # cache_dir = "";          # 缓存目录，默认使用系统缓存目录
          
          # 图片渲染设置
          image_delay = 30;          # 发送图片预览数据前等待的毫秒数，减少滚动时的卡顿
          image_filter = "triangle"; # 图片缩放滤镜，可选: "nearest", "triangle", "catmull-rom", "lanczos3"
          image_quality = 75;        # 图片预缓存质量(50-90)，值越大质量越好但CPU消耗更大
          
          # Ueberzug设置(用于某些终端的图片显示)
          # ueberzug_scale = 1.0;    # Ueberzug图片缩放比例
          # ueberzug_offset = [ 0.0 0.0 0.0 0.0 ];  # Ueberzug图片偏移量
        };

        # 任务配置
        tasks = {
          micro_workers = 10;        # 微任务最大并发数
          macro_workers = 25;        # 宏任务最大并发数
          bizarre_retry = 5;         # 异常失败时的最大重试次数
          suppress_preload = false;  # 不抑制预加载任务显示
          
          # 图片处理限制
          image_alloc = 536870912;   # 单张图片解码的最大内存分配(512MB)，0为无限制  
          image_bound = [ 0 0 ];     # 单张图片解码的最大尺寸[宽度, 高度]，0为无限制
        };

        # 插件配置
        plugin = {
          # 预加载器配置 - 在后台预加载文件信息
          prepend_preloaders = [
            # 可以添加自定义预加载器
            # { mime = "image/heic"; run = "heic"; }
          ];
          
          # 预览器配置 - 文件预览插件
          prepend_previewers = [
            # 可以添加自定义预览器  
            # { name = "*.md"; run = "markdown"; }
          ];
        };

        # 输入框配置
        input = {
          cursor_blink = true;       # 启用光标闪烁
          
          # 各种输入框的标题配置
          cd_title = "Change directory:";
          create_title = [ "Create:" "Create directory:" ];
          rename_title = "Rename:";
          filter_title = "Filter:";
          find_title = [ "Find next:" "Find previous:" ];
          search_title = "Search via {n}:";
          shell_title = [ "Shell:" "Shell (block):" ];
        };

        # 确认对话框配置
        confirm = {
          # 各种操作的确认对话框标题
          trash_title = "Move {n} selected file{s} to trash? (y/N)";
          delete_title = "Delete {n} selected file{s} permanently? (y/N)";
        };

        # 选择器配置
        pick = {
          open_title = "Open with:";
        };

        # Which面板配置(快捷键提示面板)
        which = {
          sort_by = "none";          # 候选项排序方式: "none", "key", "desc"
          sort_sensitive = false;    # 不区分大小写排序
          sort_reverse = false;      # 不反向排序
          sort_translit = false;     # 不进行字符音译
        };

        # 日志配置
        log = {
          enabled = false;           # 默认关闭日志，需要调试时可开启
        };
      };

      # 快捷键配置 - 对应keymap.toml
      keymap = {
        # 管理器模式快捷键
        mgr.prepend_keymap = [
          # 一些常用的快捷键示例
          { run = "escape"; on = [ "<Esc>" ]; }         # ESC键退出当前模式
          { run = "quit"; on = [ "q" ]; }               # q键退出程序  
          { run = "close"; on = [ "<C-q>" ]; }          # Ctrl+q退出程序
          # 可以根据个人习惯添加更多快捷键
        ];

        # 输入模式快捷键
        input.prepend_keymap = [
          { run = "close"; on = [ "<C-q>" ]; }          # Ctrl+q关闭输入框
          { run = "close --submit"; on = [ "<Enter>" ]; } # Enter提交输入
          { run = "escape"; on = [ "<Esc>" ]; }         # ESC取消输入
          { run = "backspace"; on = [ "<Backspace>" ]; } # 退格键删除字符
        ];
      };

      # 主题配置 - 对应theme.toml
      theme = {
        # Flavor配置 - 这是正确的设置主题的方式
        flavor = {
          # dark = "catppuccin-latte";  # 设置深色模式主题
          # light = "catppuccin-latte";  # 如果需要，也可以设置浅色模式主题
        };
        
        # 可以在这里覆盖 flavor 的某些颜色设置
        # 文件类型颜色配置
        filetype = {
          rules = [
            # 常见文件类型颜色设置
            { fg = "#7AD9E5"; mime = "image/*"; }         # 图片文件 - 青色
            { fg = "#F3D398"; mime = "video/*"; }         # 视频文件 - 黄色  
            { fg = "#F3D398"; mime = "audio/*"; }         # 音频文件 - 黄色
            { fg = "#CD9EFC"; mime = "application/zip"; } # 压缩文件 - 紫色
            { fg = "#CD9EFC"; mime = "application/gzip"; } # gzip文件 - 紫色
            { fg = "#A6E3A1"; mime = "text/*"; }          # 文本文件 - 绿色
          ];
        };
      };

      # Lua插件配置文件 - 对应init.lua
      initLua = ''
        -- Yazi Lua初始化配置
        -- 可以在这里添加自定义的Lua脚本来扩展Yazi功能
        
        -- 主题配置说明：
        -- 默认主题已设置为 "catppuccin-frappe"（在 theme.toml 的 [flavor] 部分）
        -- 
        -- 你也可以通过以下方式临时切换主题：
        -- 1. 在 yazi 中按 T 键选择主题
        -- 2. 设置环境变量: export YAZI_FLAVOR="catppuccin-frappe"
        -- 3. 使用命令行参数: yazi --flavor=catppuccin-frappe
        --
        -- 要永久更改默认主题，请修改 homemanager.nix 中的 theme.flavor.dark 配置

        -- 可用的主题：
        -- - catppuccin-frappe (当前默认)
        -- - catppuccin-mocha
        -- - catppuccin-macchiato  
        -- - catppuccin-latte
        -- - dracula
        
        -- 示例：自定义状态栏
        -- function Status:name()
        --   local h = cx.active.current.hovered
        --   if not h then
        --     return ui.Span("")
        --   end
        --   return ui.Span(" " .. h.name)
        -- end
        
        -- 可以添加更多自定义函数和配置
      '';

      # 插件配置 - 安装的Yazi插件
      plugins = {
        # 这里可以添加从GitHub等安装的Yazi插件
        # 示例插件配置：
        # "plugin-name" = pkgs.fetchFromGitHub {
        #   owner = "plugin-author";
        #   repo = "plugin-repo";
        #   rev = "commit-hash";
        #   sha256 = "hash";
        # };
      };

      # 主题包配置 - 预制主题
      flavors = {
        # Catppuccin 主题系列 - 现代化暖色调主题
        "catppuccin-mocha" = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "flavors";
          rev = "main";  # 使用最新的 main 分支
          sha256 = "sha256-RtunaCs1RUfzjefFLFu5qLRASbyk5RUILWTdavThRkc=";
        } + "/catppuccin-mocha.yazi";
        
        "catppuccin-macchiato" = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "flavors";
          rev = "main";
          sha256 = "sha256-RtunaCs1RUfzjefFLFu5qLRASbyk5RUILWTdavThRkc=";
        } + "/catppuccin-macchiato.yazi";
        
        "catppuccin-frappe" = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "flavors";
          rev = "main";
          sha256 = "sha256-RtunaCs1RUfzjefFLFu5qLRASbyk5RUILWTdavThRkc=";
        } + "/catppuccin-frappe.yazi";
        
        "catppuccin-latte" = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "flavors";
          rev = "main";
          sha256 = "sha256-RtunaCs1RUfzjefFLFu5qLRASbyk5RUILWTdavThRkc=";
        } + "/catppuccin-latte.yazi";
        
        # Dracula 主题 - 经典深色主题
        "dracula" = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "flavors";
          rev = "main";
          sha256 = "sha256-RtunaCs1RUfzjefFLFu5qLRASbyk5RUILWTdavThRkc=";
        } + "/dracula.yazi";
        
        # 可以添加从GitHub等安装的主题包
        # 示例主题配置：
        # "theme-name" = pkgs.fetchFromGitHub {
        #   owner = "theme-author";
        #   repo = "theme-repo"; 
        #   rev = "commit-hash";
        #   sha256 = "hash";
        # };
      };
    };
  };
}
