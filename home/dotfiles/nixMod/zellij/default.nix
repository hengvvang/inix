{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.enable && config.myHome.dotfiles.zellij.style == "nixStyle") {
    # Zellij - 现代化终端多路复用器配置
    programs.zellij = {
      enable = true;
      package = with pkgs; [
        zellij
        wl-clipboard
      ];

      # 主配置 - 现代化多路复用器设置
      settings = {
        # 界面设置
        theme = "catppuccin-mocha";  # 使用现代主题
        default_shell = "fish";      # 默认使用Fish shell

        # 性能优化
        copy_command = "wl-copy";    # Wayland剪贴板支持
        copy_clipboard = "primary";   # 剪贴板类型

        # 界面优化
        pane_frames = true;          # 显示窗格边框
        mouse_mode = true;           # 启用鼠标支持
        scrollback_editor = "nvim";  # 滚动历史编辑器

        # 会话管理
        session_serialization = true;  # 会话序列化保存
        auto_layout = true;            # 自动布局

        # 关闭启动提示
        show_startup_tips = false;     # 禁用启动时的欢迎界面和使用技巧提示

        # 键绑定设置
        keybinds = {
          # 正常模式键绑定
          normal = {
            # 基础控制
            "Ctrl q" = { Quit = {}; };
            "Ctrl d" = { Detach = {}; };

            # 窗格分割
            "Alt v" = { NewPane = "Right"; };  # 使用 v (vertical) 替代 |
            "Alt s" = { NewPane = "Down"; };   # 使用 s (split) 替代 -

            # 标签页管理
            "Alt t" = { NewTab = {}; };

            # 标签页导航
            "Alt [" = { GoToPreviousTab = {}; };
            "Alt ]" = { GoToNextTab = {}; };

            # 模式切换
            "Ctrl p" = { SwitchToMode = "Pane"; };
            "Ctrl t" = { SwitchToMode = "Tab"; };
            "Ctrl r" = { SwitchToMode = "Resize"; };
            "Ctrl s" = { SwitchToMode = "Scroll"; };
            "Ctrl o" = { SwitchToMode = "Session"; };
          };

          # 窗格模式键绑定
          pane = {
            "h" = { MoveFocus = "Left"; };
            "j" = { MoveFocus = "Down"; };
            "k" = { MoveFocus = "Up"; };
            "l" = { MoveFocus = "Right"; };
            "n" = { NewPane = {}; };
            "x" = { CloseFocus = {}; };
            "f" = { ToggleFocusFullscreen = {}; };
            "z" = { TogglePaneFrames = {}; };
            "Esc" = { SwitchToMode = "Normal"; };
          };

          # 标签页模式键绑定
          tab = {
            "h" = { GoToPreviousTab = {}; };
            "l" = { GoToNextTab = {}; };
            "n" = { NewTab = {}; };
            "q" = { CloseTab = {}; };
            "r" = { SwitchToMode = "RenameTab"; TabNameInput = []; };
            "Esc" = { SwitchToMode = "Normal"; };
          };

          # 调整大小模式键绑定
          resize = {
            "h" = { Resize = "Left"; };
            "j" = { Resize = "Down"; };
            "k" = { Resize = "Up"; };
            "l" = { Resize = "Right"; };
            "=" = { Resize = "Increase"; };
            "-" = { Resize = "Decrease"; };
            "Esc" = { SwitchToMode = "Normal"; };
          };

          # 滚动模式键绑定
          scroll = {
            "j" = { ScrollDown = {}; };
            "k" = { ScrollUp = {}; };
            "d" = { HalfPageScrollDown = {}; };
            "u" = { HalfPageScrollUp = {}; };
            "Esc" = { SwitchToMode = "Normal"; };
          };
        };

        # 布局配置
        layouts = {
          # 默认开发布局
          default = {
            tabs = [
              {
                name = "Editor";
                panes = [
                  {
                    split_direction = "vertical";
                    parts = [
                      { split_size = { Percent = 80; }; }
                      { split_size = { Percent = 20; }; }
                    ];
                  }
                ];
              }
              {
                name = "Terminal";
                panes = [ {} ];
              }
            ];
          };

          # 三列开发布局
          dev = {
            tabs = [
              {
                name = "Code";
                panes = [
                  {
                    split_direction = "horizontal";
                    parts = [
                      {
                        split_direction = "vertical";
                        split_size = { Percent = 70; };
                        parts = [
                          { split_size = { Percent = 60; }; }
                          { split_size = { Percent = 40; }; }
                        ];
                      }
                      { split_size = { Percent = 30; }; }
                    ];
                  }
                ];
              }
            ];
          };
        };

        # 插件配置
        plugins = {
          # 状态栏插件
          status-bar = { path = "status-bar"; };
          strider = { path = "strider"; };
          tab-bar = { path = "tab-bar"; };
        };

        # UI配置
        ui = {
          pane_frames = {
            rounded_corners = true;
            hide_session_name = false;
          };
        };
      };
    };

    # Shell集成配置
    programs.fish.shellInit = lib.mkIf config.programs.fish.enable ''
      # Zellij 自动启动和附加逻辑
      if status is-interactive
        # 检查是否已在Zellij会话中
        if not set -q ZELLIJ
          # 如果有现有会话，列出并选择
          if zellij list-sessions 2>/dev/null | grep -q .
            echo "现有Zellij会话:"
            zellij list-sessions
            echo "使用 'zellij attach <session-name>' 来附加到现有会话"
            echo "或者继续创建新会话..."
          end

          # 可选：自动启动zellij（取消注释下行以启用）
          # zellij attach -c default
        end
      end
    '';

    # Bash集成（如果启用）
    programs.bash.initExtra = lib.mkIf config.programs.bash.enable ''
      # Zellij 会话管理函数
      zj() {
        if [ $# -eq 0 ]; then
          zellij attach -c default
        else
          zellij attach -c "$1"
        fi
      }
    '';

    # 相关工具配置
    home.packages = with pkgs; [
      # 剪贴板工具（Wayland）
      wl-clipboard
      # 可选：主题和字体
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
    ];
  };
}
