{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "homemanager") {
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
        zed = "zeditor";

        # 导航快捷键
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        
        # Git 简化命令
        g = "git";
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git log --oneline --graph";
        gd = "git diff";
        
        
        # 系统信息
        ports = "netstat -tulanp";
        h = "history";
        
        # 快速编辑配置
        fishrc = "$EDITOR ~/.config/fish/config.fish";
        vimrc = "$EDITOR ~/.vimrc";
      };
      
      # Shell 初始化
      shellInit = ''
        # 简洁的欢迎信息
        set -g fish_greeting ""
        
        # 核心环境变量
        set -gx EDITOR nvim
        set -gx TERM xterm-256color
        
        # Starship 配置
        set -gx STARSHIP_CONFIG ~/.config/starship.toml
        
        # 路径设置
        fish_add_path ~/.local/bin
        fish_add_path ~/.cargo/bin
        
        # 现代化工具设置
        set -gx BAT_THEME "TwoDark"
        set -gx FZF_DEFAULT_OPTS "--height 40% --border --preview 'bat --color=always {}'"
      '';
      
      # 实用函数
      functions = {
        
        myip = {
          description = "获取公网IP";
          body = ''
            curl -s ifconfig.me
          '';
        };
        
        server = {
          description = "快速启动HTTP服务器";
          body = ''
            set -l port 8000
            if test (count $argv) -gt 0
              set port $argv[1]
            end
            echo "启动HTTP服务器在端口 $port"
            python3 -m http.server $port
          '';
        };
        
      
      # 交互式Shell设置
      interactiveShellInit = ''
        # 现代化键绑定
        bind \e\[1\;5C forward-word
        bind \e\[1\;5D backward-word
        
        # Ctrl+F 使用fzf搜索文件
        bind \cf 'fzf_cd'
        
        # 历史设置
        set -g fish_history_timeout 60
        
        # 禁用fish自带的提示符（使用Starship）
        functions --erase fish_prompt
        functions --erase fish_right_prompt
        
        
        # 设置终端标题
        function fish_title
          # 显示当前目录和命令
          echo (prompt_pwd) (__fish_git_prompt " (%s)")
        end
      '';
      };
    };
  };
}


