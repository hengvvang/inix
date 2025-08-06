{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "direct") {

    home.file.".config/fish/config.fish" = {
      text = ''
        # Fish Shell 配置文件
        # 配置方式: direct - 直接文件配置

        # 欢迎消息
        echo "🐠 Fish Direct Mode Loaded"

        # 环境变量设置
        set -gx EDITOR vim
        set -gx VISUAL $EDITOR
        set -gx PAGER less
        set -gx LESS "-R"

        # 路径设置
        set -gx PATH $HOME/.local/bin $PATH

        # Fish 特定设置
        set fish_greeting "欢迎使用 Fish Shell! 🐠"
        set fish_color_normal normal
        set fish_color_command blue
        set fish_color_quote yellow
        set fish_color_redirection cyan
        set fish_color_end green
        set fish_color_error red
        set fish_color_param cyan
        set fish_color_comment brblack
        set fish_color_match --background=brblue
        set fish_color_selection white --bold --background=brblack
        set fish_color_search_match bryellow --background=brblack
        set fish_color_history_current --bold
        set fish_color_operator bryellow
        set fish_color_escape brcyan
        set fish_color_cwd green
        set fish_color_cwd_root red
        set fish_color_valid_path --underline
        set fish_color_autosuggestion brblack
        set fish_color_user brgreen
        set fish_color_host normal
        set fish_color_cancel -r
        set fish_pager_color_completion normal
        set fish_pager_color_description B3A06D yellow
        set fish_pager_color_prefix white --bold --underline
        set fish_pager_color_progress brwhite --background=cyan

        # 别名设置
        alias ll='ls -alF'
        alias la='ls -A'
        alias l='ls -CF'
        alias grep='grep --color=auto'

        # Git 别名
        alias g='git'
        alias gs='git status'
        alias ga='git add'
        alias gc='git commit'
        alias gp='git push'
        alias gl='git log --oneline'

        # 系统别名
        alias df='df -h'
        alias du='du -h'
        alias free='free -h'
        alias ping='ping -c 5'

        # Nix 别名
        alias rebuild='sudo nixos-rebuild switch'
        alias home-rebuild='home-manager switch'

        # 自动补全增强
        set fish_complete_path $fish_complete_path ~/.config/fish/completions

        # Vi 模式（可选）
        # fish_vi_key_bindings

        # 启动时显示系统信息（可选）
        function fish_greeting
            echo "🐠 Fish Shell - Direct Mode"
            echo "📅 $(date '+%Y-%m-%d %H:%M:%S')"
            echo "💻 $(hostname) | 👤 $USER"
            echo "🗂️  $(pwd)"
        end
      '';
    };

    # Fish 函数目录
    home.file.".config/fish/functions/mkcd.fish" = {
      text = ''
        function mkcd --description "Create directory and change to it"
            mkdir -p $argv[1]
            and cd $argv[1]
        end
      '';
    };

    home.file.".config/fish/functions/ff.fish" = {
      text = ''
        function ff --description "Find files by name"
            find . -type f -name "*$argv[1]*" 2>/dev/null
        end
      '';
    };

    home.file.".config/fish/functions/fd.fish" = {
      text = ''
        function fd --description "Find directories by name"
            find . -type d -name "*$argv[1]*" 2>/dev/null
        end
      '';
    };

    home.file.".config/fish/functions/extract.fish" = {
      text = ''
        function extract --description "Extract compressed files"
            if test (count $argv) -ne 1
                echo "Usage: extract <file>"
                return 1
            end

            set file $argv[1]

            if not test -f "$file"
                echo "Error: '$file' is not a valid file"
                return 1
            end

            switch "$file"
                case "*.tar.bz2"
                    tar xjf "$file"
                case "*.tar.gz"
                    tar xzf "$file"
                case "*.bz2"
                    bunzip2 "$file"
                case "*.gz"
                    gunzip "$file"
                case "*.tar"
                    tar xf "$file"
                case "*.tbz2"
                    tar xjf "$file"
                case "*.tgz"
                    tar xzf "$file"
                case "*.zip"
                    unzip "$file"
                case "*.7z"
                    7z x "$file"
                case "*"
                    echo "Error: Cannot extract '$file'"
                    return 1
            end
        end
      '';
    };

    home.file.".config/fish/functions/sysinfo.fish" = {
      text = ''
        function sysinfo --description "Display system information"
            echo "=== 系统信息 ==="
            echo "主机名: "(hostname)
            echo "操作系统: "(uname -s)
            echo "内核版本: "(uname -r)
            echo "CPU 架构: "(uname -m)
            echo "内存使用: "(free -h | grep '^Mem:' | awk '{print $3"/"$2}')
            echo "磁盘使用: "(df -h / | tail -1 | awk '{print $3"/"$2" ("$5")"}')
            echo "当前用户: "$USER
            echo "Shell: "$SHELL
            echo "Fish 版本: "(fish --version)
        end
      '';
    };
  };
}
