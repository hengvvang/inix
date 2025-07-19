{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "homemanager") {
    # Zsh Shell 配置 - 使用 Home Manager
    programs.zsh = {
      enable = true;
      
      package = pkgs.zsh;  # 使用默认的 Zsh 包
      
      # 自动补全配置
      enableCompletion = true;           # 启用命令补全 (推荐)
      autosuggestion.enable = true;      # 启用自动建议 (基于历史记录)
      syntaxHighlighting.enable = true;  # 启用语法高亮
      
      # 自动切换目录 - 输入目录名即可切换
      autocd = true;                     # 启用autocd功能
      
      # 历史记录配置
      history = {
        size = 10000;                    # 内存中保存的历史命令数量
        save = 100000;                   # 文件中保存的历史命令数量
        path = "$HOME/.zsh_history";     # 历史文件路径
        ignoreDups = true;               # 忽略重复命令
        ignoreSpace = true;              # 忽略以空格开头的命令
        expireDuplicatesFirst = true;    # 优先删除重复的历史记录
        extended = true;                 # 保存命令执行时间
        share = true;                    # 在多个shell会话间共享历史
      };
      
      shellAliases = {
        zj = "zellij";
      };
      
      # Shell选项配置
      defaultKeymap = "emacs";           # 默认键映射模式 (emacs/vi)
      
      # 自定义补全初始化
      completionInit = ''
        # 补全系统配置
        autoload -Uz compinit
        compinit
        
        # 补全样式配置
        zstyle ':completion:*' menu select                    # 使用菜单选择补全
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # 大小写不敏感匹配
        zstyle ':completion:*' list-colors ""                 # 使用默认颜色
        zstyle ':completion:*:descriptions' format '%B%d%b'   # 补全分组描述格式
        zstyle ':completion:*:warnings' format 'No matches for: %d'  # 无匹配时的提示
        
        # 路径补全优化
        zstyle ':completion:*' squeeze-slashes true           # 压缩多个斜杠
        zstyle ':completion:*' special-dirs true              # 补全 . 和 ..
      '';
      
      # 交互式Shell初始化
      initContent = ''
        # 登录时的特定设置
        if [[ -o login ]]; then
          # 设置umask
          umask 022
          
          # 检查SSH代理
          if [ -z "$SSH_AUTH_SOCK" ] && command -v ssh-agent >/dev/null; then
            eval "$(ssh-agent -s)" >/dev/null
          fi
        fi
        
        # 核心环境变量
        export EDITOR="''${EDITOR:-vim}"
        export VISUAL="''${VISUAL:-$EDITOR}"
        export PAGER="''${PAGER:-less}"
        export TERM="''${TERM:-xterm-256color}"
        
        # 路径配置
        typeset -U path                  # 确保PATH中没有重复项
        path=(~/.local/bin ~/.cargo/bin $path)
        
        # 现代化工具配置
        export BAT_THEME="''${BAT_THEME:-TwoDark}"
        export FZF_DEFAULT_OPTS="''${FZF_DEFAULT_OPTS:---height 40% --border}"
        export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
        
        # Zsh选项配置
        setopt AUTO_CD                   # 自动切换目录
        setopt AUTO_PUSHD               # 自动将目录推入栈
        setopt PUSHD_IGNORE_DUPS        # 忽略重复的目录
        setopt PUSHD_MINUS              # 交换 +/- 的含义
        setopt EXTENDED_GLOB            # 扩展通配符
        setopt GLOB_DOTS                # 通配符匹配点文件
        setopt NUMERIC_GLOB_SORT        # 数字排序
        setopt NO_CASE_GLOB             # 大小写不敏感通配符
        
        # 历史记录选项
        setopt HIST_VERIFY              # 历史扩展前确认
        setopt HIST_NO_STORE            # 不保存history命令
        setopt HIST_REDUCE_BLANKS       # 去除多余空格
        
        # 作业控制
        setopt NOTIFY                   # 立即通知后台作业状态变化
        setopt NO_HUP                   # shell退出时不发送HUP信号给作业
        
        # 输入/输出
        setopt CORRECT                  # 命令纠错
        setopt NO_CORRECT_ALL           # 不纠错参数
        setopt INTERACTIVE_COMMENTS     # 允许交互式注释
        
        # 键绑定配置
        bindkey '^[[1;5C' forward-word     # Ctrl+Right: 前进一个单词
        bindkey '^[[1;5D' backward-word    # Ctrl+Left: 后退一个单词
        bindkey '^[[3~' delete-char        # Delete键
        bindkey '^[[H' beginning-of-line   # Home键
        bindkey '^[[F' end-of-line         # End键
        
        # 自定义函数
        
        # 获取公网IP
        function myip() {
          curl -s ifconfig.me
        }
        
        # 快速创建目录并进入
        function mkcd() {
          mkdir -p "$@" && cd "$_"
        }
        
        # 快速查找文件
        function ff() {
          find . -type f -name "*$1*" 2>/dev/null
        }
        
        # 快速查找目录
        function fdd() {
          find . -type d -name "*$1*" 2>/dev/null
        }
        
        # 快速HTTP服务器
        function serve() {
          local port=''${1:-8000}
          echo "在端口 $port 启动HTTP服务器..."
          python3 -m http.server $port
        }
        
        # 简单的系统信息
        function sysinfo() {
          echo "系统信息:"
          echo "操作系统: $(uname -s)"
          echo "内核版本: $(uname -r)"
          echo "主机名: $(hostname)"
          echo "当前用户: $(whoami)"
          echo "Shell: $SHELL"
          echo "终端: $TERM"
        }
        
        # 快速备份文件
        function backup() {
          cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
        }
        
        # 解压万能函数
        function extract() {
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
              *)           echo "'$1' 无法解压" ;;
            esac
          else
            echo "'$1' 不是有效的文件"
          fi
        }
        
        # 如果存在本地配置文件则加载
        [ -f ~/.zshrc.local ] && source ~/.zshrc.local
        
        # 欢迎信息（简洁版）
        if [[ $- == *i* ]] && [[ -z $ZSH_DISABLE_GREETING ]]; then
          echo "欢迎使用 Zsh! 输入 'sysinfo' 查看系统信息"
        fi
      '';
      
      # 环境变量配置
      envExtra = ''
        # 附加环境变量设置
        # 这些变量会在shell初始化之前设置
        export LESSHISTFILE="-"  # 禁用less历史文件
        export MANPAGER="less -X"  # man页面分页器设置
      '';
      
      # 配置目录
      dotDir = ".config/zsh";             # zsh配置目录 (相对于HOME)
      
      # Oh My Zsh 配置（可选，默认关闭）
      oh-my-zsh = {
        enable = false;                  # 默认关闭，避免过度配置
        # 如果启用，可以配置以下选项：
        # plugins = [ "git" "sudo" "docker" "kubectl" ];
        # theme = "robbyrussell";
        # custom = "$HOME/.oh-my-zsh/custom";
      };
      
      # Zsh插件配置（轻量级替代oh-my-zsh）
      plugins = [
        # 可以在这里添加轻量级插件
        # 例如：z跳转、fzf集成等
        # {
        #   name = "zsh-z";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "agkozak";
        #     repo = "zsh-z";
        #     rev = "v1.12";
        #     sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        #   };
        # }
      ];
    };
  };
}
