{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "direct") {
    home.file.".zshrc".text = ''
      # Zsh 基础配置
      export HISTFILE=~/.zsh_history
      export HISTSIZE=10000
      export SAVEHIST=10000
      setopt HIST_IGNORE_DUPS
      setopt HIST_FIND_NO_DUPS
      setopt HIST_REDUCE_BLANKS
      
      # 环境变量
      export EDITOR=vim
      export BROWSER=google-chrome
      export TERM=xterm-256color
      
      # 基础别名
      alias ll='ls -la'
      alias la='ls -a'
      alias l='ls'
      alias ..='cd ..'
      alias ...='cd ../..'
      
      # Git 别名
      alias gs='git status'
      alias ga='git add'
      alias gc='git commit'
      alias gp='git push'
      alias gl='git log --oneline'
      
      # 现代工具别名
      alias cat='bat'
      alias find='fd'
      alias grep='rg'
      
      # 快捷函数
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }
      
      # 简单提示符
      PS1="%n@%m:%~$ "
    '';
  };
}
