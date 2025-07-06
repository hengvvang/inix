{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "homemanager") {
    # 方式1: Home Manager 程序模块
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      history = {
        size = 10000;
        save = 10000;
        ignoreDups = true;
        ignoreSpace = true;
        share = true;
      };
      
      shellAliases = {
        ll = "ls -alF";
        la = "ls -A";
        l = "ls -CF";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        
        # Git 别名
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git log --oneline";
        gd = "git diff";
        gb = "git branch";
        gco = "git checkout";
        
        # 现代工具别名
        cat = "bat";
        ls = "eza --icons";
        tree = "eza --tree";
        find = "fd";
        grep = "rg";
        du = "dust";
        df = "duf";
        ps = "procs";
        top = "btop";
      };
      
      sessionVariables = {
        EDITOR = "vim";
        BROWSER = "google-chrome";
        TERM = "xterm-256color";
      };
      
      initExtra = ''
        # 自动补全设置
        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        
        # 目录导航
        setopt AUTO_CD
        setopt AUTO_PUSHD
        setopt PUSHD_IGNORE_DUPS
        
        # 键绑定
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        bindkey '^[[1;5C' forward-word
        bindkey '^[[1;5D' backward-word
        
        # 自定义提示符
        autoload -U colors && colors
        PROMPT='%{$fg[cyan]%}%n@%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$ '
      '';
    };
  };
}
