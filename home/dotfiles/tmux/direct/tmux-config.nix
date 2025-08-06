{ config, lib, pkgs, ... }:

{
  # Tmux 基本设置
  shell = "${pkgs.bash}/bin/bash";
  terminal = "screen-256color";
  baseIndex = 1;
  keyMode = "vi";
  prefix = "C-a";
  mouse = true;
  clock24 = true;
  escapeTime = 0;
  historyLimit = 10000;
  
  # 额外配置
  extraConfig = ''
    # Tmux 配置文件 - Direct Mode
    # ================================

    # 基本设置
    set -g default-terminal "screen-256color"
    set -ga terminal-overrides ",xterm-256color:Tc"
    
    # 鼠标支持
    set -g mouse on
    
    # Vi 模式
    setw -g mode-keys vi
    
    # 窗口和面板索引从 1 开始
    set -g base-index 1
    setw -g pane-base-index 1
    
    # 重新编号窗口
    set -g renumber-windows on
    
    # 增加历史记录限制
    set -g history-limit 10000
    
    # 减少延迟
    set -sg escape-time 0
    
    # 自动重命名窗口
    setw -g automatic-rename on
    set -g set-titles on
    
    # 活动监控
    setw -g monitor-activity on
    set -g visual-activity off
    
    # === 键绑定 ===
    
    # 重新绑定前缀键
    unbind C-b
    set -g prefix C-a
    bind C-a send-prefix
    
    # 重载配置文件
    bind r source-file ~/.tmux.conf \; display "配置已重载!"
    
    # 分割窗口
    bind | split-window -h -c "#{pane_current_path}"
    bind - split-window -v -c "#{pane_current_path}"
    unbind '"'
    unbind %
    
    # 创建新窗口
    bind c new-window -c "#{pane_current_path}"
    
    # 面板导航 (Vi 风格)
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R
    
    # 面板大小调整
    bind -r H resize-pane -L 5
    bind -r J resize-pane -D 5
    bind -r K resize-pane -U 5
    bind -r L resize-pane -R 5
    
    # 窗口导航
    bind -r C-h previous-window
    bind -r C-l next-window
    
    # 复制模式 (Vi 风格)
    bind Escape copy-mode
    bind -T copy-mode-vi v send-keys -X begin-selection
    bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"
    bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
    
    # 粘贴
    bind p paste-buffer
    
    # === 外观设置 ===
    
    # 状态栏设置
    set -g status on
    set -g status-interval 5
    set -g status-position bottom
    set -g status-justify left
    
    # 颜色方案 (GitHub Dark 主题)
    set -g status-style 'bg=#21262d,fg=#c9d1d9'
    
    # 窗口状态样式
    setw -g window-status-style 'fg=#7d8590,bg=#21262d'
    setw -g window-status-current-style 'fg=#58a6ff,bg=#21262d,bold'
    setw -g window-status-activity-style 'fg=#f85149,bg=#21262d'
    
    # 面板边框
    set -g pane-border-style 'fg=#30363d'
    set -g pane-active-border-style 'fg=#58a6ff'
    
    # 消息样式
    set -g message-style 'fg=#c9d1d9,bg=#21262d'
    set -g message-command-style 'fg=#c9d1d9,bg=#21262d'
    
    # 状态栏左侧
    set -g status-left-length 20
    set -g status-left '#[fg=#58a6ff,bg=#21262d,bold] ❐ #S #[fg=#7d8590]│ '
    
    # 状态栏右侧
    set -g status-right-length 50
    set -g status-right '#[fg=#7d8590]│ #[fg=#58a6ff]%H:%M #[fg=#7d8590]│ #[fg=#58a6ff]%Y-%m-%d '
    
    # 窗口状态格式
    setw -g window-status-format ' #I:#W#F '
    setw -g window-status-current-format ' #I:#W#F '
    
    # === 插件设置区域 ===
    # 如果使用 TPM 插件管理器，可以在这里添加插件
    # set -g @plugin 'tmux-plugins/tpm'
    # set -g @plugin 'tmux-plugins/tmux-sensible'
    # set -g @plugin 'tmux-plugins/tmux-yank'
    
    # 初始化 TPM (保持在配置文件最底部)
    # run '~/.tmux/plugins/tpm/tpm'
  '';
}
