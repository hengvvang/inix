{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "direct") {
    home.packages = with pkgs; [ fish ];
    
    # 直接文件写入 - 演示用简化配置
    home.file.".config/fish/config.fish".text = ''
      # Fish Shell 简化配置
      
      # 禁用欢迎信息
      set -g fish_greeting ""
      
      # 基础环境变量
      set -gx EDITOR nvim
      set -gx TERM xterm-256color
      
      # 常用别名
      alias ll='ls -alF'
      alias ..='cd ..'
      alias gs='git status'
      alias ga='git add'
      alias gc='git commit'
      
      # 现代工具别名
      alias cat='bat --style=auto'
      alias ls='eza --icons'
      alias find='fd'
      alias grep='rg'
      
      # 实用函数
      function mkcd
          mkdir -p $argv
          and cd $argv
      end
    '';
  };
}
