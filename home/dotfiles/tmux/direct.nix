{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.enable && 
                    config.myHome.dotfiles.tmux.method == "direct") {

    home.packages = with pkgs; [ tmux ];
    
    home.file.".config/tmux/tmux.conf".text = ''
      # Tmux 简化配置
      
      # 基础设置
      set -g default-terminal "tmux-256color"
      set -g mouse on
      set -g base-index 1
      set -g escape-time 0
      set -g history-limit 100000
      
      # 前缀键
      set -g prefix C-a
      unbind C-b
      bind C-a send-prefix
      
      # 窗口分割
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      
      # Vi 模式面板切换
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # 状态栏 - Tokyo Night
      set -g status-style 'bg=#1a1b26,fg=#c0caf5'
      set -g window-status-current-style 'fg=#1a1b26,bg=#7aa2f7,bold'
      set -g pane-active-border-style 'fg=#7aa2f7'
      
      # 重载配置
      bind r source-file ~/.config/tmux/tmux.conf \; display "配置已重载!"
    '';
  };
}
