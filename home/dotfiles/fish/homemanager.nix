{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "homemanager") {
    # Fish Shell - 现代化Shell配置
    programs.fish = {
      enable = true;
      
      # 实用别名 - 现代化工具替代
      shellAliases = {
        # 基础命令增强
        ll = "eza -alF --icons";
        la = "eza -A --icons";
        l = "eza -CF --icons";
        tree = "eza --tree --icons";
        
        # 导航快捷键
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        
        # Git 简化命令
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git log --oneline --graph";
        gd = "git diff";
        
        # 现代工具替代
        cat = "bat --style=auto";
        find = "fd";
        grep = "rg";
        du = "dust";
        df = "duf";
        ps = "procs";
        top = "btop";
      };
      
      # Shell 初始化
      shellInit = ''
        # 简洁的欢迎信息
        set -g fish_greeting ""
        
        # 核心环境变量
        set -gx EDITOR nvim
        set -gx TERM xterm-256color
        
        # 路径设置
        fish_add_path ~/.local/bin
        fish_add_path ~/.cargo/bin
      '';
      
      # 实用函数
      functions = {
        mkcd = {
          description = "创建目录并进入";
          body = ''
            mkdir -p $argv
            and cd $argv
          '';
        };
        
        fzf_cd = {
          description = "使用fzf选择目录";
          body = ''
            cd (find . -type d | fzf)
          '';
        };
      };
      
      # 交互式Shell设置
      interactiveShellInit = ''
        # 现代化键绑定
        bind \e\[1\;5C forward-word
        bind \e\[1\;5D backward-word
        
        # 历史设置
        set -g fish_history_timeout 60
      '';
    };
  };
}
