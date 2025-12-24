{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.configStyle == "homeManager") {

    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor;
      # 扩展包环境 - 为 Zed 提供额外工具
      extraPackages = with pkgs; [
      ];

      # 扩展列表 - Zed 插件
      extensions = [
        # === 语言支持扩展 ===
        "nix"                    # Nix 语言支持
        "rust"                   # Rust 语言支持
        "python"                 # Python 语言支持
        "typescript"             # TypeScript 语言支持
        "html"                   # HTML 语言支持
        "css"                    # CSS 语言支持

        # === 版本控制 ===
        "git-firefly"            # Git 集成增强

        # === 主题和界面 ===
        "catppuccin"             # Catppuccin 主题

        # === 实用工具 ===
        "file-icons"             # 文件图标
        "vim"                    # Vim 键位绑定
      ];

      # 用户设置配置
      userSettings = {
        # === 编辑器基础设置 ===
        "buffer_font_family" = "JetBrains Mono";         # 编辑器字体
        "buffer_font_size" = 14;                          # 字体大小
        "ui_font_family" = "JetBrains Mono";             # 界面字体
        "ui_font_size" = 13;                              # 界面字体大小

        # === 主题设置 ===
        "theme" = {
          "mode" = "dark";                                # 主题模式
          "light" = "Catppuccin Latte";                  # 亮色主题
          "dark" = "Catppuccin Mocha";                   # 暗色主题
        };

        # === 编辑器行为 ===
        "tab_size" = 2;                                   # Tab 大小
        "hard_tabs" = false;                              # 使用空格替代 Tab
        "show_whitespaces" = "selection";                 # 显示空白字符
        "wrap_guides" = [ 80 120 ];                       # 换行参考线
        "preferred_line_length" = 80;                     # 首选行长度
        "soft_wrap" = "prefer_line";                      # 软换行模式

        # === 搜索和导航 ===
        "scrollbar" = {
          "show" = "always";                              # 总是显示滚动条
        };
        "minimap" = {
          "enabled" = true;                               # 启用迷你地图
        };

        # === 文件处理 ===
        "remove_trailing_whitespace_on_save" = true;     # 保存时删除行尾空格
        "ensure_final_newline_on_save" = true;           # 保存时确保文件末尾有换行
        "format_on_save" = "on";                          # 保存时自动格式化

        # === 版本控制 ===
        "git" = {
          "git_gutter" = "tracked_files";                 # Git 装订线显示
        };

        # === 语言特定设置 ===
        "languages" = {
          "Nix" = {
            "tab_size" = 2;
            "hard_tabs" = false;
            "formatter" = "language_server";
          };
          "Python" = {
            "tab_size" = 4;
            "hard_tabs" = false;
            "formatter" = "language_server";
          };
          "Rust" = {
            "tab_size" = 4;
            "hard_tabs" = false;
            "formatter" = "language_server";
          };
          "JavaScript" = {
            "tab_size" = 2;
            "hard_tabs" = false;
            "formatter" = "prettier";
          };
          "TypeScript" = {
            "tab_size" = 2;
            "hard_tabs" = false;
            "formatter" = "prettier";
          };
        };

        # === 终端设置 ===
        "terminal" = {
          "shell" = {
            "program" = "${pkgs.fish}/bin/fish";         # 默认终端 Shell
          };
          "font_family" = "JetBrains Mono";              # 终端字体
          "font_size" = 13;                              # 终端字体大小
        };

        # === 性能和隐私 ===
        "telemetry" = {
          "metrics" = false;                              # 关闭度量收集
          "diagnostics" = false;                          # 关闭诊断数据
        };
        "auto_update" = false;                            # 关闭自动更新

        # === 协作功能 ===
        "collaboration_panel" = {
          "button" = false;                               # 隐藏协作按钮
        };
      };

      # 键盘快捷键配置
      userKeymaps = [
        # === Vim 风格导航 ===
        {
          "context" = "Editor";
          "bindings" = {
            "ctrl-h" = "pane::ActivateNextItem";
            "ctrl-l" = "pane::ActivatePrevItem";
            "ctrl-j" = "editor::MoveDown";
            "ctrl-k" = "editor::MoveUp";
          };
        }
        # === 文件操作 ===
        {
          "context" = "Workspace";
          "bindings" = {
            "ctrl-shift-e" = "workspace::ToggleLeftDock";
            "ctrl-shift-f" = "project_search::ToggleFocus";
            "ctrl-shift-g" = "editor::ToggleGitBlame";
          };
        }
        # === 编辑操作 ===
        {
          "context" = "Editor";
          "bindings" = {
            "ctrl-/" = "editor::ToggleComments";
            "ctrl-shift-p" = "command_palette::Toggle";
            "ctrl-p" = "file_finder::Toggle";
          };
        }
      ];

      # 自定义主题 (可选)
      themes = {
        "Custom Dark" = {
          "name" = "Custom Dark";
          "appearance" = "dark";
          "style" = {
            "background" = "#1e1e2e";
            "foreground" = "#cdd6f4";
            "selection" = "#313244";
            "cursor" = "#f5e0dc";
            "terminal.background" = "#1e1e2e";
            "terminal.foreground" = "#cdd6f4";
          };
        };
      };
    };

    # 启用远程服务器支持 (可选)
    programs.zed-editor.installRemoteServer = true;
  };
}
