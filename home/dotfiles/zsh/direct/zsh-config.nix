{ config, lib, pkgs, ... }:

{
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  autocd = true;
  
  history = {
    size = 10000;
    save = 100000;
    path = "$HOME/.zsh_history";
    ignoreDups = true;
    ignoreSpace = true;
    expireDuplicatesFirst = true;
    extended = true;
    share = true;
  };
  
  shellAliases = {
    zj = "zellij";
    zed = "zeditor";
    ll = "ls -alF";
    la = "ls -A";
    l = "ls -CF";
    grep = "grep --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
  };
  
  defaultKeymap = "emacs";
  
  completionInit = ''
    # 补全系统配置
    autoload -Uz compinit
    compinit
    
    # 补全样式配置
    zstyle ':completion:*' menu select
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    zstyle ':completion:*' list-colors ""
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:warnings' format 'No matches for: %d'
    zstyle ':completion:*' squeeze-slashes true
    zstyle ':completion:*' special-dirs true
  '';
  
  initContent = ''
    export EDITOR="''${EDITOR:-vim}"
    export TERM="xterm-256color"
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
    export PATH="$HOME/.local/bin:$PATH"
    
    # Zsh选项配置
    setopt AUTO_CD
    setopt AUTO_PUSHD
    setopt PUSHD_IGNORE_DUPS
    setopt PUSHD_MINUS
    setopt EXTENDED_GLOB
    setopt GLOB_DOTS
    setopt NUMERIC_GLOB_SORT
    setopt NO_CASE_GLOB
    setopt HIST_VERIFY
    setopt HIST_NO_STORE
    setopt CORRECT
    setopt NO_CORRECT_ALL
    setopt INTERACTIVE_COMMENTS
    
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
  
  envExtra = ''
    # 额外的环境变量配置
  '';
  
  oh-my-zsh = {
    enable = false;
  };
  
  plugins = [];
}
