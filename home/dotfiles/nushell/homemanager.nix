{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "homemanager") {
    # 方式1: Home Manager 程序模块（推荐）
    # 特点：声明式配置，与 Home Manager 深度集成，易于管理
    programs.nushell = {
      enable = true;
      
      # Nushell 包版本配置
      # 使用默认包，如需特定版本可指定: pkgs.nushell
      package = pkgs.nushell;
      
      # 核心配置设置 - 影响 Nushell 的行为和外观
      settings = {
        # 启动横幅控制 - 关闭启动时的欢迎信息
        show_banner = false;
        
        # 历史记录配置
        history = {
          # 使用 SQLite 格式存储历史（推荐，性能更好）
          format = "sqlite";
          # 历史记录文件位置（默认值）
          # file_format = "sqlite";
          # 最大历史条目数
          max_size = 100000;
          # 同步间隔（毫秒）
          sync_on_enter = true;
        };
        
        # 自动补全配置
        completions = {
          # 补全算法：prefix（前缀匹配）或 fuzzy（模糊匹配）
          algorithm = "fuzzy";
          # 补全菜单是否区分大小写
          case_sensitive = false;
          # 快速补全（在输入时立即显示）
          quick = true;
          # 部分补全（允许部分匹配的结果）
          partial = true;
          # 外部命令补全
          external = {
            enable = true;
            # 最大补全结果数
            max_results = 100;
            # 补全超时（毫秒）
            completer = null; # 使用默认
          };
        };
        
        # 表格显示配置
        table = {
          # 表格显示模式：rounded, heavy, compact, light, thin, none
          mode = "rounded";
          # 表格索引模式：always, never, auto
          index_mode = "auto";
          # 表格标题是否显示
          show_empty = true;
          # 表格分页
          page_size = 25;
        };
        
        # 错误处理配置
        error_style = "fancy"; # fancy 或 plain
        
        # 光标形状配置
        cursor_shape = {
          # 插入模式光标：line, block, underscore
          insert = "line";
          # 普通模式光标  
          normal = "block";
        };
        
        # 颜色配置
        color_config = {
          # 使用默认颜色主题
          # 可选：dark, light 或自定义配置
          # 这里使用默认值
        };
        
        # 文件大小格式：binary (1024) 或 decimal (1000)
        filesize = {
          metric = false; # 使用二进制（1024）
          format = "auto"; # auto, b, kb, mb, gb, tb, pb
        };
        
        # 浮点数显示精度
        float_precision = 4;
        
        # 使用 ANSI 颜色
        use_ansi_coloring = true;
        
        # 编辑模式：emacs 或 vi
        edit_mode = "emacs";
        
        # Shell 集成功能
        shell_integration = {
          # 启用右侧提示符集成
          osc2 = true;
          # 启用终端标题设置
          osc7 = true;
          # 启用终端序列集成
          osc8 = true;
          # 启用终端重置
          osc9_9 = false;
          # 启用工作目录报告
          osc133 = true;
          # 启用终端标记
          osc633 = true;
          # 重置应用模式
          reset_application_mode = true;
        };
        
        # 钩子配置（保持空，避免复杂脚本）
        hooks = {
          pre_prompt = [ ];
          pre_execution = [ ];
          env_change = {
            PWD = [ ];
          };
          display_output = [ ];
          command_not_found = [ ];
        };
        
        # 菜单配置
        menus = [
          # 补全菜单配置
          {
            name = "completion_menu";
            only_buffer_difference = false;
            marker = "| ";
            type = {
              layout = "columnar";
              columns = 4;
              col_width = 20;
              col_padding = 2;
            };
            style = {
              text = "green";
              selected_text = "green_reverse";
              description_text = "yellow";
            };
          }
          # 历史菜单配置
          {
            name = "history_menu";
            only_buffer_difference = true;
            marker = "? ";
            type = {
              layout = "list";
              page_size = 10;
            };
            style = {
              text = "green";
              selected_text = "green_reverse";
              description_text = "yellow";
            };
          }
        ];
        
        # 快捷键绑定（保持最小化配置）
        keybindings = [
          {
            name = "completion_menu";
            modifier = "none";
            keycode = "tab";
            mode = "emacs";
            event = { send = "menu"; name = "completion_menu"; };
          }
          {
            name = "history_menu";
            modifier = "control";
            keycode = "char_r";
            mode = "emacs"; 
            event = { send = "menu"; name = "history_menu"; };
          }
        ];
      };
      
      # 环境变量配置 - 设置 Nushell 专用的环境变量
      environmentVariables = {
        # 编辑器配置
        EDITOR = "nvim";
        # 分页器配置  
        PAGER = "less";
        # 默认浏览器
        BROWSER = "firefox";
        # Nushell 配置目录
        NU_CONFIG_DIR = "$HOME/.config/nushell";
        # 禁用遥测（如果需要）
        # NU_DISABLE_TELEMETRY = "1";
      };
      
      # 基础命令别名（仅包含最常用的几个）
      shellAliases = {
        # 文件操作别名
        ll = "ls -la";
        la = "ls -a";
        # Git 别名
        g = "git";
        gs = "git status";
        # 系统别名
        cls = "clear";
      };
      
      # 插件配置 - 添加有用的 Nushell 插件
      plugins = with pkgs.nushellPlugins; [
        # 格式化插件 - 支持更多文件格式
        # formats
        # 查询插件 - 增强查询功能
        # query
        # 网络插件 - 网络相关功能
        # net
        # 注意：这些插件需要在 nixpkgs 中可用才能启用
      ];
      
      # 额外配置 - 用于添加自定义 Nushell 代码
      extraConfig = ''
        # 自定义提示符（简单配置）
        $env.PROMPT_INDICATOR = "❯ "
        $env.PROMPT_INDICATOR_VI_INSERT = ": "
        $env.PROMPT_INDICATOR_VI_NORMAL = "❯ "
        
        # 设置 ls 的默认颜色
        $env.LS_COLORS = (vivid generate molokai | str trim)
        
        # 启动时的简单欢迎信息（如果需要）
        # print "Welcome to Nushell!"
      '';
      
      # 额外环境配置 - 添加到环境变量文件
      extraEnv = ''
        # PATH 配置示例
        # $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
        
        # 自定义环境转换器
        $env.ENV_CONVERSIONS = {
          "PATH": {
            from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
            to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
          }
        }
      '';
      
      # 登录时执行的配置
      extraLogin = ''
        # 登录时的初始化脚本
        # 这里可以添加登录时需要执行的命令
        
        # 示例：设置代理（如果需要）
        # $env.HTTP_PROXY = "http://proxy.example.com:8080"
        # $env.HTTPS_PROXY = "http://proxy.example.com:8080"
      '';
    };
  };
}
