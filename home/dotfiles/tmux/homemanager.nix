{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.tmux.enable && 
                    config.myHome.dotfiles.tmux.method == "homemanager") {
    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      historyLimit = 100000;
      keyMode = "vi";
      mouse = true;
      escapeTime = 0;
      baseIndex = 1;
      
      # 自定义配置
      extraConfig = ''
        # 人体工程学键位绑定
        # 前缀键改为 Ctrl+a（更符合人体工程学）
        set -g prefix C-a
        unbind C-b
        bind C-a send-prefix
        
        # 快速重载配置
        bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
        
        # 更直观的窗口分割
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        unbind '"'
        unbind %
        
        # 新窗口在当前目录创建
        bind c new-window -c "#{pane_current_path}"
        
        # Vi 模式键位
        setw -g mode-keys vi
        bind -T copy-mode-vi v send-keys -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
        bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
        
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
        
        # 快速面板切换
        bind -n M-1 select-window -t 1
        bind -n M-2 select-window -t 2
        bind -n M-3 select-window -t 3
        bind -n M-4 select-window -t 4
        bind -n M-5 select-window -t 5
        bind -n M-6 select-window -t 6
        bind -n M-7 select-window -t 7
        bind -n M-8 select-window -t 8
        bind -n M-9 select-window -t 9
        
        # 面板编号从1开始
        set -g pane-base-index 1
        set -g renumber-windows on
        
        # 显示设置
        set -g display-panes-time 2000
        set -g display-time 2000
        set -g status-interval 1
        
        # 状态栏设置
        set -g status-position bottom
        set -g status-justify left
        set -g status-style 'bg=#1a1b26 fg=#c0caf5'
        
        # 窗口状态
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
        
        # 活动监控
        setw -g monitor-activity on
        set -g visual-activity off
        
        # 自动重命名
        setw -g automatic-rename on
        set -g set-titles on
        set -g set-titles-string "#T"
        
        # 真彩色支持
        set -g default-terminal "tmux-256color"
        set -ag terminal-overrides ",xterm-256color:RGB"
        
        # 聚焦事件
        set -g focus-events on
        
        # 面板同步
        bind S setw synchronize-panes
        
        # 会话管理
        bind C-s choose-session
        bind C-w choose-window
        
        # 快速清屏
        bind C-l send-keys 'C-l'
        
        # 面板最大化/最小化
        bind m resize-pane -Z
      '';
      
      # 插件配置
      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        resurrect
        continuum
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-capture-pane-contents 'on'
            set -g @resurrect-strategy-vim 'session'
            set -g @resurrect-strategy-nvim 'session'
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '15'
          '';
        }
      ];
    };
  };
}
