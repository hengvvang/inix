{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.enable && config.myHome.dotfiles.tmux.style == "nixStyle") {
    programs.tmux = {
      enable = true;
      package = pkgs.tmux;
      # Shell 设置
      shell = "${pkgs.fish}/bin/fish";  # 使用 fish shell
      terminal = "tmux-256color";       # 终端类型，支持真彩色

      # 基础索引设置
      baseIndex = 1;                    # 窗口从 1 开始编号

      # 键位模式
      keyMode = "vi";                   # 使用 Vi 键位模式

      # 前缀键设置
      prefix = "C-a";                   # 前缀键改为 Ctrl+a

      # 鼠标支持
      mouse = true;                     # 启用鼠标支持

      # 历史记录设置
      historyLimit = 100000;            # 增加历史记录限制

      # 转义时间
      escapeTime = 0;                   # 减少转义延迟

      # 窗口重新编号
      disableConfirmationPrompt = true;  # 禁用确认提示

      # 自定义键绑定
      extraConfig = ''
        # === 基本设置 ===
        set -g pane-base-index 1                # 面板从 1 开始编号
        set -g renumber-windows on              # 自动重新编号窗口
        set -g display-panes-time 2000          # 显示面板编号时间
        set -g display-time 2000                # 消息显示时间
        set -g status-interval 1                # 状态栏更新间隔
        set -g focus-events on                  # 启用聚焦事件

        # === 窗口和面板管理 ===
        # 更直观的窗口分割
        bind | split-window -h -c "#{pane_current_path}"  # 垂直分割
        bind - split-window -v -c "#{pane_current_path}"  # 水平分割
        unbind '"'
        unbind %

        # 新窗口在当前目录创建
        bind c new-window -c "#{pane_current_path}"

        # 面板间移动（Vi 风格）
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # 面板大小调整
        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5

        # 窗口切换
        bind -n M-h previous-window
        bind -n M-l next-window

        # 快速窗口选择
        bind -n M-1 select-window -t 1
        bind -n M-2 select-window -t 2
        bind -n M-3 select-window -t 3
        bind -n M-4 select-window -t 4
        bind -n M-5 select-window -t 5

        # === 复制模式配置 ===
        bind -T copy-mode-vi v send-keys -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'
        bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'wl-copy'

        # === 会话管理 ===
        bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
        bind C-s choose-session
        bind C-w choose-window
        bind m resize-pane -Z              # 面板最大化/最小化
        bind S setw synchronize-panes      # 面板同步

        # === 外观设置 ===
        # 状态栏位置和样式
        set -g status-position bottom
        set -g status-justify left
        set -g status-style 'bg=#1a1b26 fg=#c0caf5'

        # 窗口状态样式
        set -g window-status-current-style 'bg=#7aa2f7 fg=#1a1b26 bold'
        set -g window-status-style 'bg=#414868 fg=#c0caf5'
        set -g window-status-separator ' '

        # 左侧状态栏
        set -g status-left-length 40
        set -g status-left '#[bg=#9ece6a,fg=#1a1b26,bold] #S #[bg=#1a1b26,fg=#9ece6a]'

        # 右侧状态栏
        set -g status-right-length 80
        set -g status-right '#[bg=#1a1b26,fg=#7aa2f7]#[bg=#7aa2f7,fg=#1a1b26] %Y-%m-%d %H:%M #[bg=#1a1b26,fg=#f7768e]#[bg=#f7768e,fg=#1a1b26] #h '

        # 面板边框
        set -g pane-border-style 'fg=#414868'
        set -g pane-active-border-style 'fg=#7aa2f7'

        # 消息样式
        set -g message-style 'bg=#7aa2f7 fg=#1a1b26 bold'
        set -g message-command-style 'bg=#f7768e fg=#1a1b26 bold'

        # 复制模式样式
        set -g mode-style 'bg=#7aa2f7 fg=#1a1b26 bold'

        # === 监控设置 ===
        setw -g monitor-activity on        # 监控活动
        set -g visual-activity off         # 关闭视觉活动提示

        # === 自动重命名 ===
        setw -g automatic-rename on        # 自动重命名窗口
        set -g set-titles on               # 设置终端标题
        set -g set-titles-string "#T"      # 标题字符串格式

        # === 终端特性 ===
        set -ag terminal-overrides ",xterm-256color:RGB"  # 真彩色支持
      '';

      # 插件配置（可选，如果需要插件支持）
      plugins = with pkgs.tmuxPlugins; [
        # 常用插件示例（注释掉的可以根据需要启用）
        # sensible          # 合理的默认设置
        # resurrect         # 会话保存/恢复
        # continuum         # 自动保存会话
        # yank              # 改进的复制功能
        # prefix-highlight  # 前缀键高亮
      ];
    };
  };
}
