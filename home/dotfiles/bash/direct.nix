{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "direct") {
    # 直接文件写入方式配置 Bash
    
    home.file.".bashrc".text = ''
      # === Bash 配置文件 ===
      # 由 Nix Home Manager 生成
      
      # 如果不是交互式shell，直接返回
      case $- in
        *i*) ;;
          *) return;;
      esac
      
      # === 历史设置 ===
      HISTCONTROL=ignoredups:ignorespace
      HISTSIZE=10000
      HISTFILESIZE=20000
      
      # === Shell 选项 ===
      shopt -s histappend
      shopt -s checkwinsize
      shopt -s cdspell
      shopt -s dirspell
      shopt -s autocd
      shopt -s globstar
      shopt -s checkjobs
      
      # === 环境变量 ===
      export EDITOR="vim"
      export VISUAL="vim"
      export TERM="xterm-256color"
      export LANG="en_US.UTF-8"
      export LC_ALL="en_US.UTF-8"
      export PATH="$HOME/.local/bin:$PATH"
      
      # === 颜色支持 ===
      if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      fi
      
      # === 别名定义 ===
      alias ls='ls --color=auto'
      alias ll='ls -alF'
      alias la='ls -A'
      alias l='ls -CF'
      
      alias rm='rm -i'
      alias cp='cp -i'
      alias mv='mv -i'
      
      alias ..='cd ..'
      alias ...='cd ../..'
      alias ....='cd ../../..'
      alias .....='cd ../../../..'
      
      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
      
      alias h='history'
      alias j='jobs -l'
      alias which='type -a'
      
      # Git 快捷方式
      alias g='git'
      alias gs='git status'
      alias ga='git add'
      alias gc='git commit'
      alias gp='git push'
      alias gl='git log --oneline'
      alias gd='git diff'


      # 系统信息
      alias ports='netstat -tulanp'
      alias mount='mount | column -t'
      
      # 快速编辑配置
      alias bashrc='$EDITOR ~/.bashrc'
      alias vimrc='$EDITOR ~/.vimrc'
      
      # === 实用函数 ===

      # 获取公网IP
      myip() {
        curl -s ifconfig.me
      }
      
      # 快速启动HTTP服务器
      server() {
        local port="''${1:-8000}"
        echo "启动HTTP服务器在端口 $port"
        python3 -m http.server "$port"
      }
      
      # === 键绑定设置 ===
      set -o emacs
      
      # === 补全设置 ===
      if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
          . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
          . /etc/bash_completion
        fi
      fi
      
      # === 终端标题设置 ===
      case "$TERM" in
        xterm*|rxvt*)
          PROMPT_COMMAND='echo -ne "\033]0;''${USER}@''${HOSTNAME}: ''${PWD}\007"'
          ;;
        *)
          ;;
      esac
      
      # === Starship 提示符 ===
      export STARSHIP_CONFIG="$HOME/.config/starship.toml"
      
      # 初始化 Starship (如果已安装)
      if command -v starship &> /dev/null; then
        eval "$(starship init bash)"
      fi
      
      # === 本地自定义配置 ===
      if [ -f "$HOME/.bashrc.local" ]; then
        source "$HOME/.bashrc.local"
      fi
    '';
    
    # .bash_profile 配置
    home.file.".bash_profile".text = ''
      # === Bash Profile 配置 ===
      # 由 Nix Home Manager 生成
      
      # 设置默认权限
      umask 022
      
      # 启动SSH代理
      if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)" > /dev/null 2>&1
      fi
      
      # 加载 .bashrc
      if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
      fi
    '';
  };
}
