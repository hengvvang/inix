{ config, lib, pkgs, ... }:

{
  # Zsh 基本配置
  enableCompletion = true;
  autosuggestion = {
    enable = true;
    strategy = [ "history" "completion" ];
  };
  syntaxHighlighting = {
    enable = true;
  };
  autocd = true;
  
  # 历史设置
  history = {
    size = 10000;
    save = 10000;
    ignoreDups = true;
    ignoreSpace = true;
    expireDuplicatesFirst = true;
    share = true;
  };

  # Shell 别名
  shellAliases = {
    # 基本命令增强
    ll = "ls -alF";
    la = "ls -A";
    l = "ls -CF";
    grep = "grep --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";
    
    # Git 快捷命令
    g = "git";
    gs = "git status";
    ga = "git add";
    gc = "git commit";
    gp = "git push";
    gl = "git log --oneline";
    
    # 系统管理
    df = "df -h";
    du = "du -h";
    free = "free -h";
    ps = "ps aux";
    
    # 网络工具
    ping = "ping -c 5";
    wget = "wget -c";
    
    # Nix 快捷命令
    rebuild = "sudo nixos-rebuild switch";
    home-rebuild = "home-manager switch";
    
    # 现代替代工具
    cat = "bat";
    find = "fd";
    ls = "exa";
    ps = "procs";
    top = "htop";
  };

  # 初始化脚本
  initExtra = ''
    # Zsh 直接配置模式
    echo "⚡ Zsh Direct Mode Loaded"

    # 设置提示符主题
    autoload -U promptinit
    promptinit

    # 自定义提示符
    setopt PROMPT_SUBST
    PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '
    RPROMPT='%F{yellow}%T%f'

    # 环境变量设置
    export EDITOR="vim"
    export VISUAL="$EDITOR"
    export PAGER="less"
    export LESS="-R"

    # 颜色支持
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad

    # 路径设置
    export PATH="$HOME/.local/bin:$PATH"

    # Zsh 选项设置
    setopt AUTO_CD              # 自动切换目录
    setopt GLOB_DOTS            # 包含隐藏文件在 glob 匹配中
    setopt EXTENDED_GLOB        # 扩展 glob 功能
    setopt NUMERIC_GLOB_SORT    # 数字排序
    setopt NO_CASE_GLOB         # 忽略大小写匹配
    setopt CORRECT              # 命令纠错
    setopt CORRECT_ALL          # 参数纠错

    # 历史选项
    setopt HIST_IGNORE_DUPS     # 忽略重复历史
    setopt HIST_IGNORE_SPACE    # 忽略空格开头的命令
    setopt HIST_VERIFY          # 历史扩展时确认
    setopt SHARE_HISTORY        # 共享历史
    setopt EXTENDED_HISTORY     # 扩展历史格式

    # 补全选项
    setopt AUTO_LIST            # 自动列出补全
    setopt AUTO_MENU            # 自动菜单补全
    setopt COMPLETE_IN_WORD     # 在单词中间补全
    setopt ALWAYS_TO_END        # 补全后移动到末尾

    # 补全样式设置
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    zstyle ':completion:*' list-colors "''${(@s.:.)LS_COLORS}"
    zstyle ':completion:*' menu select
    zstyle ':completion:*' group-name ""
    zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'

    # 函数定义
    # 快速创建目录并进入
    mkcd() {
        mkdir -p "$1" && cd "$1"
    }

    # 查找文件
    ff() {
        find . -type f -name "*$1*" 2>/dev/null
    }

    # 查找目录
    fd() {
        find . -type d -name "*$1*" 2>/dev/null
    }

    # 提取压缩文件
    extract() {
        if [ -f "$1" ]; then
            case "$1" in
                *.tar.bz2)   tar xjf "$1"     ;;
                *.tar.gz)    tar xzf "$1"     ;;
                *.bz2)       bunzip2 "$1"    ;;
                *.rar)       unrar x "$1"    ;;
                *.gz)        gunzip "$1"     ;;
                *.tar)       tar xf "$1"     ;;
                *.tbz2)      tar xjf "$1"    ;;
                *.tgz)       tar xzf "$1"    ;;
                *.zip)       unzip "$1"      ;;
                *.Z)         uncompress "$1" ;;
                *.7z)        7z x "$1"       ;;
                *)           echo "无法提取 '$1'" ;;
            esac
        else
            echo "'$1' 不是有效文件"
        fi
    }

    # 显示系统信息
    sysinfo() {
        echo "=== 系统信息 ==="
        echo "主机名: $(hostname)"
        echo "操作系统: $(uname -s)"
        echo "内核版本: $(uname -r)"
        echo "CPU 架构: $(uname -m)"
        echo "内存使用: $(free -h | grep '^Mem:' | awk '{print $3"/"$2}')"
        echo "磁盘使用: $(df -h / | tail -1 | awk '{print $3"/"$2" ("$5")"}')"
        echo "当前用户: $USER"
        echo "Shell: $SHELL"
        echo "Zsh 版本: $ZSH_VERSION"
    }

    # 键绑定
    bindkey '^R' history-incremental-search-backward
    bindkey '^F' history-incremental-search-forward
    bindkey '^A' beginning-of-line
    bindkey '^E' end-of-line
    bindkey '^K' kill-line
    bindkey '^U' kill-whole-line
    bindkey '^W' backward-kill-word
    bindkey '^H' backward-delete-char
    bindkey '^?' backward-delete-char

    # Oh My Zsh 兼容性（如果需要）
    # export ZSH="$HOME/.oh-my-zsh"
    # ZSH_THEME="robbyrussell"
    # plugins=(git)
    # source $ZSH/oh-my-zsh.sh

    # Starship 提示符（如果安装了）
    # eval "$(starship init zsh)"
  '';

  # 登出脚本
  logoutExtra = ''
    # 清理工作
    echo "👋 Zsh 会话结束"
  '';
}
