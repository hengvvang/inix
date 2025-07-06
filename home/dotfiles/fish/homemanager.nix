{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.dotfiles.fish.enable {
    # 方式1: Home Manager 程序模块
    programs.fish = {
      enable = true;
      
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
      
      shellInit = ''
        # Fish Shell 初始化
        set -g fish_greeting ""
        
        # 环境变量
        set -gx EDITOR vim
        set -gx BROWSER google-chrome
        set -gx TERM xterm-256color
        
        # 路径设置
        fish_add_path ~/.local/bin
        fish_add_path ~/.cargo/bin
      '';
      
      functions = {
        mkcd = {
          description = "Create directory and change to it";
          body = ''
            mkdir -p $argv
            and cd $argv
          '';
        };
        
        extract = {
          description = "Extract various archive formats";
          body = ''
            if test -f $argv[1]
                switch $argv[1]
                    case '*.tar.bz2'
                        tar xjf $argv[1]
                    case '*.tar.gz'
                        tar xzf $argv[1]
                    case '*.bz2'
                        bunzip2 $argv[1]
                    case '*.rar'
                        unrar x $argv[1]
                    case '*.gz'
                        gunzip $argv[1]
                    case '*.tar'
                        tar xf $argv[1]
                    case '*.tbz2'
                        tar xjf $argv[1]
                    case '*.tgz'
                        tar xzf $argv[1]
                    case '*.zip'
                        unzip $argv[1]
                    case '*.Z'
                        uncompress $argv[1]
                    case '*.7z'
                        7z x $argv[1]
                    case '*'
                        echo "'$argv[1]' cannot be extracted via extract()"
                end
            else
                echo "'$argv[1]' is not a valid file"
            end
          '';
        };
      };
      
      interactiveShellInit = ''
        # 键绑定
        bind \e\[1\;5C forward-word
        bind \e\[1\;5D backward-word
      '';
    };
  };
}
