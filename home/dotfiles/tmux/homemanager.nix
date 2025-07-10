{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.enable && config.myHome.dotfiles.tmux.method == "homemanager") {
    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      historyLimit = 100000;
      keyMode = "vi";
      mouse = true;
      
      extraConfig = ''
        # 基础设置
        set -g prefix C-a
        unbind C-b
        bind-key C-a send-prefix
        
        # 重新加载配置
        bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"
        
        # 窗口和面板索引从1开始
        set -g base-index 1
        setw -g pane-base-index 1
        
        # 面板分割
        bind | split-window -h
        bind - split-window -v
        
        # 面板导航
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R
        
        # 调整面板大小
        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5
        
        # 复制模式
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection
        
        # 终端标题
        set -g set-titles on
        set -g set-titles-string "#T - #W"
        
        # 活动监控
        setw -g monitor-activity on
        set -g visual-activity on
        
        # 颜色设置
        set -g default-terminal "tmux-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        
        # 状态栏设置
        set -g status-position bottom
        set -g status-justify left
        set -g status-style "bg=#1a1b26 fg=#c0caf5"
        
        # 窗口状态
        set -g window-status-current-style "bg=#7aa2f7 fg=#1a1b26 bold"
        set -g window-status-style "bg=#414868 fg=#c0caf5"
        set -g window-status-separator " "
        
        # 左侧状态栏
        set -g status-left-length 40
        set -g status-left "#[fg=#7aa2f7,bg=#1a1b26,bold] #S #[fg=#c0caf5,bg=#414868] #(whoami) "
        
        # 右侧状态栏
        set -g status-right-length 50
        set -g status-right "#[fg=#c0caf5,bg=#414868] %Y-%m-%d %H:%M #[fg=#7aa2f7,bg=#1a1b26,bold] #h "
        
        # 面板边框
        set -g pane-border-style "fg=#414868"
        set -g pane-active-border-style "fg=#7aa2f7"
        
        # 消息栏
        set -g message-style "bg=#f7768e fg=#1a1b26 bold"
        set -g message-command-style "bg=#e0af68 fg=#1a1b26 bold"
        
        # 时间显示
        set -g display-panes-time 2000
        set -g display-time 2000
        set -g status-interval 1
        
        # 自动重命名
        set -g automatic-rename on
        set -g automatic-rename-format "#{b:pane_current_path}"
        
        # 窗口切换
        bind -n M-H previous-window
        bind -n M-L next-window
        
        # 面板同步
        bind C-s setw synchronize-panes
        
        # 快速会话切换
        bind-key -r f run-shell "tmux neww tmux-sessionizer"
      '';
      
      plugins = with pkgs; [
        tmuxPlugins.sensible
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.yank
        tmuxPlugins.resurrect
        tmuxPlugins.continuum
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-vim 'session'
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-capture-pane-contents 'on'
          '';
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-boot 'on'
            set -g @continuum-save-interval '60'
          '';
        }
      ];
    };
  };
}
