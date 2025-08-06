{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "direct") {
    home.file.".config/fish/config.fish" = {
      text = ''
        # Fish Shell 直接配置 - Direct Method
        # 这是使用 direct 方式的 Fish Shell 配置示例

        # === 基础设置 ===
        # 设置默认编辑器
        set -gx EDITOR vim

        # 禁用欢迎消息
        set -g fish_greeting

        # === 路径配置 ===
        # 添加自定义路径到 PATH
        fish_add_path ~/.local/bin
        fish_add_path ~/.cargo/bin
        fish_add_path ~/.local/share/pnpm

        # === 别名配置 ===
        alias ll='ls -la'
        alias la='ls -A'
        alias l='ls -CF'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'

        # 工具别名
        alias zj='zellij'
        alias zed='zeditor'
        alias ya='yazi'
        alias yz='yazi'

        # Git 别名
        alias g='git'
        alias ga='git add'
        alias gc='git commit'
        alias gs='git status'
        alias gp='git push'
        alias gl='git pull'

        # === 缩写配置 ===
        # Fish 特有的缩写功能，输入后自动扩展
        abbr -a gs 'git status'
        abbr -a ga 'git add'
        abbr -a gc 'git commit'
        abbr -a gp 'git push'
        abbr -a gl 'git pull'
        abbr -a gco 'git checkout'
        abbr -a gb 'git branch'
        abbr -a gd 'git diff'
        abbr -a gl 'git log --oneline'

        # 系统管理缩写
        abbr -a ll 'ls -la'
        abbr -a la 'ls -A'
        abbr -a cd.. 'cd ..'
        abbr -a .. 'cd ..'
        abbr -a ... 'cd ../..'

        # 编辑器缩写
        abbr -a v 'vim'
        abbr -a e '$EDITOR'

        # === 环境变量 ===
        # 设置颜色支持
        set -gx TERM xterm-256color

        # 设置 Fish 颜色
        set -g fish_color_normal normal
        set -g fish_color_command blue
        set -g fish_color_quote green
        set -g fish_color_redirection magenta
        set -g fish_color_end red
        set -g fish_color_error red --bold
        set -g fish_color_param white
        set -g fish_color_comment yellow
        set -g fish_color_match cyan
        set -g fish_color_search_match --background=yellow
        set -g fish_color_operator cyan
        set -g fish_color_escape cyan
        set -g fish_color_autosuggestion 555

        # === 键绑定 ===
        # Ctrl+l 清屏
        bind \cl 'clear; commandline -f repaint'

        # === 条件配置 ===
        # 如果 starship 存在，初始化它
        if command -v starship >/dev/null
            starship init fish | source
        end

        # 如果 zoxide 存在，初始化它
        if command -v zoxide >/dev/null
            zoxide init fish | source
        end

        # 如果 direnv 存在，初始化它
        if command -v direnv >/dev/null
            direnv hook fish | source
        end

        # === 自定义函数 ===
        # 快速创建目录并进入
        function mkcd
            mkdir -p $argv[1] && cd $argv[1]
        end

        # 快速查找文件
        function ff
            find . -name "*$argv[1]*"
        end

        # 快速查找并编辑文件
        function fe
            set file (find . -name "*$argv[1]*" | head -1)
            if test -n "$file"
                $EDITOR $file
            else
                echo "File not found: $argv[1]"
            end
        end

        # === 平台特定配置 ===
        switch (uname)
        case Linux
            # Linux 特定配置
            alias open='xdg-open'
            set -gx BROWSER firefox
        case Darwin
            # macOS 特定配置
            set -gx BROWSER safari
        case '*'
            # 其他系统配置
        end
      '';
    };
  };
}
