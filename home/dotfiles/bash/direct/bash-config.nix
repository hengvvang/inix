{ config, lib, pkgs, ... }:

{
  # Bash 历史设置
  historySize = 10000;
  historyFileSize = 50000;
  historyControl = [ "ignoredups" "ignorespace" ];
  historyIgnore = [ "ls" "cd" "exit" ];

  # 启用自动补全
  enableCompletion = true;

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
    nix-shell = "nix-shell --run bash";
    rebuild = "sudo nixos-rebuild switch";
    home-rebuild = "home-manager switch";
  };

  # Shell 选项
  shellOptions = [
    "histappend"
    "checkwinsize"
    "extglob"
    "globstar"
    "checkjobs"
  ];

  # 初始化脚本
  initExtra = ''
    # Bash 直接配置模式
    echo "🐚 Bash Direct Mode Loaded"

    # 设置提示符颜色
    export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

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
    }
  '';

  # 登出脚本
  logoutExtra = ''
    # 清理临时文件
    # 显示登出消息
    echo "👋 Bash 会话结束"
  '';
}
