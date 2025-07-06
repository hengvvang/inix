{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.dotfiles.fish.enable {
    # 方式2: 直接文件写入
    home.file.".config/fish/config.fish".text = ''
      # Fish Shell 配置文件 - 直接文件写入方式
      
      # 禁用欢迎信息
      set -g fish_greeting ""
      
      # 环境变量
      set -gx EDITOR vim
      set -gx BROWSER google-chrome
      set -gx TERM xterm-256color
      
      # 路径设置
      fish_add_path ~/.local/bin
      fish_add_path ~/.cargo/bin
      
      # 别名
      alias ll='ls -alF'
      alias la='ls -A'
      alias l='ls -CF'
      alias grep='grep --color=auto'
      alias ..='cd ..'
      alias ...='cd ../..'
      alias ....='cd ../../..'
      
      # Git 别名
      alias gs='git status'
      alias ga='git add'
      alias gc='git commit'
      alias gp='git push'
      alias gl='git log --oneline'
      alias gd='git diff'
      alias gb='git branch'
      alias gco='git checkout'
      
      # 现代工具别名
      alias cat='bat'
      alias ls='eza --icons'
      alias tree='eza --tree'
      alias find='fd'
      alias grep='rg'
      alias du='dust'
      alias df='duf'
      alias ps='procs'
      alias top='btop'
      
      # 键绑定
      bind \e\[1\;5C forward-word
      bind \e\[1\;5D backward-word
    '';
    
    # Fish 函数文件
    home.file.".config/fish/functions/mkcd.fish".text = ''
      function mkcd
          mkdir -p $argv
          and cd $argv
      end
    '';
    
    home.file.".config/fish/functions/extract.fish".text = ''
      function extract
          if test -f $argv[1]
              switch $argv[1]
                  case '*.tar.bz2'
                      tar xjf $argv[1]
                  case '*.tar.gz'
                      tar xzf $argv[1]
                  case '*.bz2'
                      bunzip2 $argv[1]
                  case '*.rar'
                      unrar x $argv[1]
                  case '*.gz'
                      gunzip $argv[1]
                  case '*.tar'
                      tar xf $argv[1]
                  case '*.tbz2'
                      tar xjf $argv[1]
                  case '*.tgz'
                      tar xzf $argv[1]
                  case '*.zip'
                      unzip $argv[1]
                  case '*.Z'
                      uncompress $argv[1]
                  case '*.7z'
                      7z x $argv[1]
                  case '*'
                      echo "'$argv[1]' cannot be extracted via extract()"
              end
          else
              echo "'$argv[1]' is not a valid file"
          end
      end
    '';
  };
}
