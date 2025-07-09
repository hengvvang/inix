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
      
      # 现代化工具替代
      alias cat='bat --style=plain'
      alias tree='eza --tree'
      alias find='fd'
      alias top='htop'
      
      # Nix 相关
      alias nr='nix run'
      alias ns='nix search'
      alias nd='nix develop'
      alias nb='nix build'
      
      # 系统信息
      alias ports='netstat -tulanp'
      alias mount='mount | column -t'
      
      # 快速编辑配置
      alias bashrc='$EDITOR ~/.bashrc'
      alias vimrc='$EDITOR ~/.vimrc'
      
      # === 实用函数 ===
      
      # 创建目录并进入
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }
      
      # 提取各种压缩文件
      extract() {
        if [ -f "$1" ]; then
          case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *.xz)        unxz "$1"        ;;
            *.lzma)      unlzma "$1"      ;;
            *)           echo "不支持的文件格式: '$1'" ;;
          esac
        else
          echo "文件不存在: '$1'"
        fi
      }
      
      # 快速搜索文件
      ff() {
        find . -type f -iname "*$1*" 2>/dev/null
      }
      
      # 快速搜索目录
      fd() {
        find . -type d -iname "*$1*" 2>/dev/null
      }
      
      # 显示路径中的目录
      path() {
        echo "$PATH" | tr ':' '\n' | nl
      }
      
      # 快速返回父目录
      up() {
        local d=""
        local limit="$1"
        
        if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
          limit=1
        fi
        
        for ((i=1; i<=limit; i++)); do
          d="../$d"
        done
        
        if [ "$d" != "" ]; then
          cd "$d" || return
        fi
      }
      
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
      
      # === 开发工具集成 ===
      
      # Node.js 版本管理
      if [ -d "$HOME/.nvm" ]; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
      fi
      
      # Rust 环境
      if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
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
    
    # 确保相关包可用
    home.packages = with pkgs; [
      bash
      bash-completion
      
      # 现代化工具
      bat
      eza
      fd
      ripgrep
      htop
      
      # 基础工具
      coreutils
      findutils
      gnugrep        # 修正：使用 gnugrep 而不是 grep
      gnused         # 修正：使用 gnused 而不是 sed
      gawk
      
      # 压缩工具
      unzip
      p7zip
      
      # 网络工具
      curl
      wget
      
      # 开发工具
      git
      
      # 系统信息
      neofetch
      
      # Starship 提示符
      starship
    ];
  };
}
