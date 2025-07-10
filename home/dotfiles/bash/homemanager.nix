{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "homemanager") {
    # Bash Shell 配置 - 使用 Home Manager
    programs.bash = {
      enable = true;
      
      # Bash 历史配置
      historyControl = [ "ignoredups" "ignorespace" ];
      historySize = 10000;
      historyFileSize = 20000;
      
      # 环境变量
      sessionVariables = {
        # 编辑器设置
        EDITOR = "vim";
        VISUAL = "vim";
        
        # 颜色支持
        TERM = "xterm-256color";
        
        # 语言设置
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
        
        # 路径设置
        PATH = "$HOME/.local/bin:$PATH";
      };
      
      # Shell 选项
      shellOptions = [
        # 历史选项
        "histappend"      # 追加历史而不是覆盖
        "checkwinsize"    # 检查窗口大小变化
        "cdspell"         # 自动修正cd命令的拼写错误
        "dirspell"        # 自动修正目录名的拼写错误
        "autocd"          # 输入目录名自动cd
        "globstar"        # 启用 ** 递归glob
        "checkjobs"       # 检查后台作业
        "no_empty_cmd_completion"  # 空命令行不自动补全
      ];
      
      # Shell 别名
      shellAliases = {
        # 基础命令增强
        ls = "ls --color=auto";
        ll = "ls -alF";
        la = "ls -A";
        l = "ls -CF";
        
        # 安全操作
        rm = "rm -i";
        cp = "cp -i";
        mv = "mv -i";
        
        # 目录操作
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        
        # 颜色支持
        grep = "grep --color=auto";
        fgrep = "fgrep --color=auto";
        egrep = "egrep --color=auto";
        
        # 常用工具
        h = "history";
        j = "jobs -l";
        which = "type -a";
        
        # Git 快捷方式
        g = "git";
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git log --oneline";
        gd = "git diff";
        
        # 系统信息
        ports = "netstat -tulanp";
        mount = "mount | column -t";
        
        # 快速编辑配置
        bashrc = "$EDITOR ~/.bashrc";
        vimrc = "$EDITOR ~/.vimrc";
      };
      
      # 初始化脚本
      initExtra = ''
        # === Bash 提示符和颜色设置 ===
        
        # 启用颜色支持
        if [ -x /usr/bin/dircolors ]; then
          test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        fi
        
        # === 实用函数 ===
        
        # 获取公网IP
        myip() {
          curl -s ifconfig.me
        }
        
        # === 键绑定设置 ===
        set -o emacs
        
        # === 补全设置 ===
        if ! shopt -oq posix; then
          if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
          elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
          fi
        fi
        

        # === 终端标题设置 ===
        case "$TERM" in
          xterm*|rxvt*)
            PROMPT_COMMAND='echo -ne "\033]0;''${USER}@''${HOSTNAME}: ''${PWD}\007"'
            ;;
          *)
            ;;
        esac
        
        # === Starship 提示符 ===
        export STARSHIP_CONFIG="$HOME/.config/starship.toml"
        
        # === 本地自定义配置 ===
        if [ -f "$HOME/.bashrc.local" ]; then
          source "$HOME/.bashrc.local"
        fi
      '';
      
      # 登录脚本
      profileExtra = ''
      '';
      
      # Bash 补全
      enableCompletion = true;
      
      # 集成其他工具
      # Starship 会自动集成，无需手动配置
    };
  };
}
