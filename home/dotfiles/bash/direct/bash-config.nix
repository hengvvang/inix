{ config, lib, pkgs, ... }:

{
  historySize = 10000;
  historyFileSize = 100000;
  historyControl = [ "ignoredups" "erasedups" ];
  historyIgnore = [
    "ls"
    "cd" 
    "pwd"
    "exit"
    "clear"
    "history"
  ];
  
  enableCompletion = true;
  
  shellAliases = {
    zj = "zellij";
    zed = "zeditor";
    ll = "ls -alF";
    la = "ls -A";
    l = "ls -CF";
    grep = "grep --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";
  };
  
  shellOptions = [
    "histappend"
    "checkwinsize"
    "extglob"
    "globstar"
    "checkjobs"
    "cdspell"
    "dirspell"
    "autocd"
  ];
  
  initExtra = ''
    # 设置默认编辑器
    export EDITOR="vim"
    export VISUAL="vim"
    export TERM="xterm-256color"
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
    export PATH="$HOME/.local/bin:$PATH"
    
    # 改善 ls 颜色显示
    if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    fi
    
    # 设置更友好的提示符颜色 (如果没有其他提示符工具)
    if [ -z "$STARSHIP_SESSION_KEY" ] && [ -z "$POWERLINE_COMMAND" ]; then
      PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    fi
    
    # 常用函数
    mkcd() {
      mkdir -p "$1" && cd "$1"
    }
    
    # 提取压缩文件
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
          *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
      else
        echo "'$1' is not a valid file"
      fi
    }
  '';
  
  logoutExtra = ''
    # 清理临时文件或执行其他清理操作
    # clear
  '';
}
