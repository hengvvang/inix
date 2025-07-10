{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "homemanager") {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      # 历史配置 - 增强版
      history = {
        size = 50000;  # 增加历史记录数量
        save = 50000;
        path = "${config.xdg.dataHome}/zsh/history";
        ignoreDups = true;
        ignoreSpace = true;
        extended = true;
        share = true;  # 在多个会话间共享历史
        expireDuplicatesFirst = true;
      };
      
      # 环境变量
      sessionVariables = {
        EDITOR = "vim";
        BROWSER = "google-chrome";
        TERM = "xterm-256color";
        # 语言和编码设置
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
        # 提升开发体验
        BAT_THEME = "TwoDark";
        MANPAGER = "sh -c 'col -bx | bat -l man -p'";
        # FZF 配置
        FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border";
      };
      
      # 实用别名 - 现代化工具替代
      shellAliases = {
        # 基础命令增强
        ll = "eza -alF --icons --git";
        la = "eza -A --icons";
        l = "eza -CF --icons";
        tree = "eza --tree --icons";
        
        # 导航快捷键
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        
        # Git 简化命令（与 Oh-My-Zsh git 插件协同）
        gs = "git status";
        ga = "git add";
        gaa = "git add --all";
        gc = "git commit";
        gcm = "git commit -m";
        gp = "git push";
        gl = "git log --oneline --graph --decorate";
        gd = "git diff";
        gco = "git checkout";
        gb = "git branch";
        gf = "git fetch";
        gpl = "git pull";
        

        # 安全操作
        rm = "rm -i";
        cp = "cp -i";
        mv = "mv -i";
        
        # 快速编辑
        zshrc = "$EDITOR ~/.zshrc";
        vimrc = "$EDITOR ~/.vimrc";
        
        # 网络工具
        ping = "ping -c 5";
        
        # 系统信息
        ports = "netstat -tulanp";
        
        # 开发快捷键
        serve = "python3 -m http.server";
        myip = "curl http://ipecho.net/plain; echo";
        
        # Nix 快捷键
        nix-search = "nix search nixpkgs";
        nix-shell-p = "nix-shell -p";
      };
      
      # ZSH 高级配置
      initContent = ''
        # 补全系统优化
        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        zstyle ':completion:*' list-colors ""
        zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' special-dirs true
        zstyle ':completion:*' squeeze-slashes true
        
        # 历史搜索优化
        autoload -U up-line-or-beginning-search
        autoload -U down-line-or-beginning-search
        zle -N up-line-or-beginning-search
        zle -N down-line-or-beginning-search
        bindkey "^[[A" up-line-or-beginning-search
        bindkey "^[[B" down-line-or-beginning-search
        
        # ZSH 选项设置
        setopt AUTO_CD                 # 自动进入目录
        setopt AUTO_PUSHD              # 自动推送目录到栈
        setopt PUSHD_IGNORE_DUPS       # 忽略重复目录
        setopt PUSHD_MINUS             # 交换 +/- 的含义
        setopt EXTENDED_GLOB           # 扩展的通配符
        setopt HIST_VERIFY             # 历史展开后再执行
        setopt HIST_REDUCE_BLANKS      # 删除多余空格
        setopt HIST_IGNORE_ALL_DUPS    # 忽略所有重复
        setopt HIST_SAVE_NO_DUPS       # 保存时忽略重复
        setopt HIST_FIND_NO_DUPS       # 搜索时忽略重复
        setopt SHARE_HISTORY           # 共享历史
        setopt APPEND_HISTORY          # 追加历史
        setopt INC_APPEND_HISTORY      # 实时追加历史
        setopt CORRECT                 # 命令纠错
        setopt COMPLETE_IN_WORD        # 在单词中间补全
        setopt ALWAYS_TO_END           # 补全后光标移到末尾
        
        # 键绑定
        bindkey '^R' history-incremental-search-backward  # Ctrl+R 历史搜索
        bindkey '^S' history-incremental-search-forward   # Ctrl+S 前向搜索
        bindkey '^[[Z' reverse-menu-complete               # Shift+Tab 反向补全
        
        # 快速跳转函数
        function mkcd() {
          mkdir -p "$1" && cd "$1"
        }
        
        # 快速备份函数
        function bak() {
          cp "$1" "$1.bak"
        }
        
        # 快速查找并编辑
        function fe() {
          local file
          file=$(fd --type f | fzf) && $EDITOR "$file"
        }
        
        # 快速查找并进入目录
        function fcd() {
          local dir
          dir=$(fd --type d | fzf) && cd "$dir"
        }
        
        # Git 快速提交
        function gac() {
          git add -A && git commit -m "$1"
        }
        
        
        # 让 Starship 接管提示符
        autoload -U colors && colors
        
        # 加载 FZF 如果可用
        if command -v fzf-share >/dev/null; then
          source "$(fzf-share)/key-bindings.zsh"
          source "$(fzf-share)/completion.zsh"
        fi
      '';
      
      # Oh-My-Zsh 配置 - 强化版
      oh-my-zsh = {
        enable = true;
        # 精选插件组合
        plugins = [
          # Git 相关
          "git"
          "gitignore"
          "github"
          
          # 命令增强
          "sudo"                 # 双击 ESC 添加 sudo
          "command-not-found"    # 命令未找到建议
          "colored-man-pages"    # 彩色 man 页面
          "colorize"            # 语法高亮
          
          # 导航和搜索
          "z"                   # 智能跳转
          "fzf"                 # 模糊搜索
          "history-substring-search"  # 历史子串搜索
          
          # 开发工具
          "docker"              # Docker 补全
          "docker-compose"      # Docker Compose 补全
          "npm"                 # NPM 补全
          "pip"                 # Python pip 补全
          "rust"                # Rust 补全

          # 系统工具
          "extract"             # 通用解压
          "safe-paste"          # 安全粘贴
          "web-search"          # 网络搜索
          
          # 生产力
          "copypath"            # 复制路径
          "copyfile"            # 复制文件内容
          "copybuffer"          # 复制缓冲区
        ];
        
        # 禁用 oh-my-zsh 主题，让 Starship 接管
        theme = "";
      };
    };
  };
}
