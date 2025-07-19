{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "homemanager") {
    # Bash Shell 配置 - 使用 Home Manager
    programs.bash = {
      enable = true;
      package = pkgs.bash;  # 使用默认的 Bash 包

      # 历史记录配置
      historySize = 10000;                    # 内存中历史记录数量
      historyFileSize = 100000;               # 文件中历史记录数量
      historyControl = [ "ignoredups" "erasedups" ];  # 忽略重复命令
      historyIgnore = [                       # 忽略记录的命令模式
        "ls"
        "cd"
        "pwd"
        "exit"
        "clear"
        "history"
      ];
      
      # Bash 补全功能
      enableCompletion = true;                # 启用命令补全 (推荐)
      
      # 简单的命令别名 (象征性配置)
      shellAliases = {
        ll = "ls -alF";
        la = "ls -A";
        l = "ls -CF";
        grep = "grep --color=auto";
        fgrep = "fgrep --color=auto";
        egrep = "egrep --color=auto";
      };
      
      # Bash 选项配置
      shellOptions = [
        "histappend"        # 追加历史记录而不是覆盖
        "checkwinsize"      # 检查窗口大小
        "extglob"           # 扩展模式匹配
        "globstar"          # 递归通配符 **
        "checkjobs"         # 检查后台任务状态
        "cdspell"           # 自动纠正 cd 命令中的小错误
        "dirspell"          # 自动纠正目录名中的小错误
      ];
      
      # 初始化脚本 (象征性配置一些基础设置)
      initExtra = ''
        # 设置默认编辑器
        export EDITOR="vim"
        export VISUAL="vim"
        
        # 改善 ls 颜色显示
        if [ -x /usr/bin/dircolors ]; then
          test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        fi
        
        # 设置更友好的提示符颜色 (如果没有其他提示符工具)
        if [ -z "$STARSHIP_SESSION_KEY" ] && [ -z "$POWERLINE_COMMAND" ]; then
          PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        fi
        
        # 一个简单的函数示例 (象征性配置)
        mkcd() {
          mkdir -p "$1" && cd "$1"
        }
      '';
      
      # 退出时执行的脚本
      logoutExtra = ''
        # 清理临时文件或执行其他清理操作
        # clear
      '';
      
      # 会话变量 (如果需要设置特定的环境变量)
      sessionVariables = {
        # 这些通常在其他地方设置，这里只是示例
        # BROWSER = "firefox";
        # TERMINAL = "alacritty";
      };
      
      # 文件关联配置 (通常不需要在 bash 中设置)
      # profileExtra = '''';  # 登录时执行的额外脚本
      
      # Bash 补全相关的包 (如果需要额外的补全功能)
      # enableVteIntegration = true;  # VTE 终端集成 (GNOME Terminal, Tilix 等)
    };
  };
}
